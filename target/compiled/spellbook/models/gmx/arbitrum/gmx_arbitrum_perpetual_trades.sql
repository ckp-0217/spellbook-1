



WITH 

perp_events as (
    -- decrease position
    SELECT
        evt_block_time as block_time, 
        'decrease_position' as trade_data, 
        indexToken as virtual_asset,
        collateralToken as underlying_asset,
        sizeDelta/1E30 as volume_usd, 
        fee/1E30 as fee_usd, 
        collateralDelta/1E30 as margin_usd,
        CAST(sizeDelta as double) as volume_raw,
        CASE WHEN isLong = false THEN 'short' ELSE 'long' END as trade_type,
        account as trader, 
        contract_address as market_address, 
        evt_index,
        evt_tx_hash as tx_hash 
    FROM 
    `gmx_arbitrum`.`Vault_evt_DecreasePosition`
    
    WHERE evt_block_time >= '2021-08-31'
    
    

    UNION ALL 

    -- increase position 
    SELECT
        evt_block_time as block_time, 
        'increase_position' as trade_data, 
        indexToken as virtual_asset,
        collateralToken as underlying_asset,
        sizeDelta/1E30 as volume_usd, 
        fee/1E30 as fee_usd, 
        collateralDelta/1E30 as margin_usd,
        CAST(sizeDelta as double) as volume_raw,
        CASE WHEN isLong = false THEN 'short' ELSE 'long' END as trade_type, 
        account as trader, 
        contract_address as market_address, 
        evt_index,
        evt_tx_hash as tx_hash 
    FROM 
    `gmx_arbitrum`.`Vault_evt_IncreasePosition`
    
    WHERE evt_block_time >= '2021-08-31'
    
    

    UNION ALL 

    -- liquidate position 
    SELECT
        evt_block_time as block_time, 
        'liquidate_position' as trade_data, 
        indexToken as virtual_asset,
        collateralToken as underlying_asset,
        size/1E30 as volume_usd, 
        0 as fee_usd, 
        collateral/1E30 as margin_usd,
        CAST(size as double) as volume_raw, 
        CASE WHEN isLong = false THEN 'short' ELSE 'long' END as trade_type, 
        account as trader, 
        contract_address as market_address, 
        evt_index,
        evt_tx_hash as tx_hash 
    FROM 
    `gmx_arbitrum`.`Vault_evt_LiquidatePosition`
    
    WHERE evt_block_time >= '2021-08-31'
    
    
)

SELECT 
    'arbitrum' as blockchain, 
    'gmx' as project, 
    '1' as version, 
    date_trunc('day', pe.block_time) as block_date, 
    pe.block_time, 
    COALESCE(erc20a.symbol, pe.virtual_asset) as virtual_asset, 
    COALESCE(erc20b.symbol, pe.underlying_asset) as underlying_asset, 
    CASE 
        WHEN pe.virtual_asset = pe.underlying_asset THEN COALESCE(erc20a.symbol, pe.virtual_asset)
        ELSE COALESCE(erc20a.symbol, pe.virtual_asset) || '-' || COALESCE(erc20b.symbol, pe.underlying_asset)
    END as market, 
    pe.market_address,
    pe.volume_usd,
    pe.fee_usd,
    pe.margin_usd,
    CASE 
        WHEN pe.trade_data = 'increase_position' THEN 'open' || '-' || pe.trade_type
        WHEN pe.trade_data = 'decrease_position' THEN 'close' || '-' || pe.trade_type
        WHEN pe.trade_data = 'liquidate_position' THEN 'liquidate' || '-' || pe.trade_type
    END as trade, 
    pe.trader, 
    pe.volume_raw,
    pe.tx_hash,
    txns.to as tx_to,
    txns.from as tx_from,
    pe.evt_index
FROM 
perp_events pe 
INNER JOIN `arbitrum`.`transactions` txns 
    ON pe.tx_hash = txns.hash
    
    AND txns.block_time >= '2021-08-31'
    
    
LEFT JOIN `tokens`.`erc20` erc20a
    ON erc20a.contract_address = pe.virtual_asset
    AND erc20a.blockchain = 'arbitrum'
LEFT JOIN `tokens`.`erc20` erc20b
    ON erc20b.contract_address = pe.underlying_asset
    AND erc20b.blockchain = 'arbitrum'