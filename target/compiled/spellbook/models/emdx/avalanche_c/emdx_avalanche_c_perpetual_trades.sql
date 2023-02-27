



WITH 

perp_events as (
    SELECT evt_block_time                                                          as block_time,
           evt_block_number                                                        as block_number,
           CASE WHEN (exchangedPositionSize * 1) >= 0 THEN 'long' ELSE 'short' END as trade_type,
           ''                                                                      as virtual_asset,    -- cant find in events
           ''                                                                      as underlying_asset, -- cant find in events
           positionNotional / 1E18                                                 as volume_usd,
           fee / 1E18                                                              as fee_usd,
           margin / 1E18                                                           as margin_usd,
           CAST(positionNotional as double)                                        as volume_raw,
           trader,
           amm                                                                     as market_address,
           evt_index,
           evt_tx_hash                                                             as tx_hash
    FROM 
    `emdx_avalanche_c`.`ClearingHouse_evt_PositionChanged`
    
    WHERE evt_block_time >= '2022-05-21'
    
    
), 

trade_data as (
    -- close position calls 
    SELECT call_block_number as block_number,
           call_tx_hash      as tx_hash,
           'close'           as trade_data
    FROM 
    `emdx_avalanche_c`.`ClearingHouse_call_closePosition`
    WHERE call_success = true 
    
    AND call_block_time >= '2022-05-21'
    
    

    UNION ALL 

    -- open position calls 
    SELECT
        call_block_number as block_number,
        call_tx_hash as tx_hash,
        'open' as trade_data
    FROM 
    `emdx_avalanche_c`.`ClearingHouse_call_openPosition`
    WHERE call_success = true 
    
    AND call_block_time >= '2022-05-21'
    
    

    UNION ALL 

    -- liquidate position events
    SELECT
        evt_block_number as block_number,
        evt_tx_hash as tx_hash,
        'liquidate' as trade_data
    FROM 
    `emdx_avalanche_c`.`ClearingHouse_evt_PositionLiquidated`
    WHERE 1 = 1
    
    AND evt_block_time >= '2022-05-21'
    
    
)

SELECT 'avalanche_c'                    as blockchain,
       'emdx'                           as project,
       '1'                              as version,
       date_trunc('day', pe.block_time) as block_date,
       pe.block_time,
       pe.virtual_asset,
       pe.underlying_asset,
       ''                               as market, -- no event emitted to get data
       pe.market_address,
       pe.volume_usd,
       pe.fee_usd,
       pe.margin_usd,
       COALESCE(
                   td.trade_data || '-' || pe.trade_type, -- using the call/open functions to classify trades
                   'adjust' || '-' || pe.trade_type
           )                            as trade,
       pe.trader,
       pe.volume_raw,
       pe.tx_hash,
       txns.to                          as tx_to,
       txns.from                        as tx_from,
       pe.evt_index
FROM 
perp_events pe 
INNER JOIN 
`avalanche_c`.`transactions` txns 
    ON pe.tx_hash = txns.hash
    
    AND txns.block_time >= '2022-05-21'
    
    
LEFT JOIN 
trade_data td 
    ON pe.block_number = td.block_number
    AND pe.tx_hash = td.tx_hash