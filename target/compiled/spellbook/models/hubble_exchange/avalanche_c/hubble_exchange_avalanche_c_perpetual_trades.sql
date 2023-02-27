



WITH 

perp_events as (
    SELECT evt_block_time                                              as block_time,
           evt_block_number                                            as block_number,
           CASE WHEN (baseAsset * 1) >= 0 THEN 'long' ELSE 'short' END as trade_type,       -- negative baseAsset is for short and positive is for long
           'AVAX'                                                      as virtual_asset,    -- only AVAX can currently be traded on hubble exchange
           ''                                                          as underlying_asset, -- there's no way to track the underlying asset as traders need to deposit into their margin account before they're able to trade which is tracked in a seperate event not tied to the margin positions opened.
           quoteAsset / 1E6                                            as volume_usd,
           CAST(NULL as double)                                        as fee_usd,          -- no event to track fees
           CAST(NULL as double)                                        as margin_usd,       -- no event to track margin
           CAST(quoteAsset as double)                                  as volume_raw,
           trader,
           contract_address                                            as market_address,
           evt_index,
           evt_tx_hash                                                 as tx_hash
    FROM 
    `hubble_exchange_avalanche_c`.`ClearingHouse_evt_PositionModified`
    
    WHERE evt_block_time >= '2022-08-09'
    
    
), 

trade_data as (
    -- close position calls 
    SELECT call_block_number as block_number,
           call_tx_hash      as tx_hash,
           'close'           as trade_data
    FROM 
    `hubble_exchange_avalanche_c`.`ClearingHouse_call_closePosition`
    WHERE call_success = true 
    
    AND call_block_time >= '2022-08-09'
    
    

    UNION

    -- open position calls 
    SELECT
        call_block_number as block_number,
        call_tx_hash as tx_hash,
        'open' as trade_data
    FROM 
    `hubble_exchange_avalanche_c`.`ClearingHouse_call_openPosition`
    WHERE call_success = true 
    
    AND call_block_time >= '2022-08-09'
    
    

    UNION

    -- liquidate position events
    SELECT
        evt_block_number as block_number,
        evt_tx_hash as tx_hash,
        'liquidate' as trade_data
    FROM 
    `hubble_exchange_avalanche_c`.`ClearingHouse_evt_PositionLiquidated`
    WHERE 1 = 1
    
    AND evt_block_time >= '2022-08-09'
    
    
)

SELECT 'avalanche_c'                    as blockchain,
       'hubble_exchange'                as project,
       '1'                              as version,
       date_trunc('day', pe.block_time) as block_date,
       pe.block_time,
       pe.virtual_asset,
       pe.underlying_asset,
       'AVAX'                           as market,
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
    
    AND txns.block_time >= '2022-08-09'
    
    
LEFT JOIN 
trade_data td 
    ON pe.block_number = td.block_number
    AND pe.tx_hash = td.tx_hash