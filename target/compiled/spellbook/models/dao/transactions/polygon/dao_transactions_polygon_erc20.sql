



WITH 

dao_tmp as (
        SELECT 
            blockchain, 
            dao_creator_tool, 
            dao, 
            dao_wallet_address
        FROM 
        `dao`.`addresses_polygon`
        WHERE dao_wallet_address IS NOT NULL 
), 

transactions as (
        SELECT 
            evt_block_time as block_time, 
            evt_tx_hash as tx_hash, 
            contract_address as token, 
            value as value, 
            to as dao_wallet_address, 
            'tx_in' as tx_type,
            evt_index as tx_index,
            from as address_interacted_with,
            array(CAST(NULL AS BIGINT)) as trace_address
        FROM 
        `erc20_polygon`.`evt_transfer`
        
        WHERE evt_block_time >= '2021-09-01'
        
        
        AND to IN (SELECT dao_wallet_address FROM dao_tmp)

        UNION ALL 

        SELECT 
            evt_block_time as block_time, 
            evt_tx_hash as tx_hash, 
            contract_address as token, 
            value as value, 
            from as dao_wallet_address, 
            'tx_out' as tx_type, 
            evt_index as tx_index, 
            to as address_interacted_with,
            array(CAST(NULL AS BIGINT)) as trace_address
        FROM 
        `erc20_polygon`.`evt_transfer`
        
        WHERE evt_block_time >= '2021-09-01'
        
        
        AND from IN (SELECT dao_wallet_address FROM dao_tmp)
)

SELECT 
    dt.blockchain,
    dt.dao_creator_tool, 
    dt.dao, 
    dt.dao_wallet_address, 
    TRY_CAST(date_trunc('day', t.block_time) as DATE) as block_date, 
    t.block_time, 
    t.tx_type,
    t.token as asset_contract_address, 
    COALESCE(er.symbol, t.token) as asset,
    CAST(t.value AS DECIMAL(38,0)) as raw_value, 
    t.value/POW(10, COALESCE(er.decimals, 18)) as value, 
    t.value/POW(10, COALESCE(er.decimals, 18)) * COALESCE(p.price, dp.median_price) as usd_value, 
    t.tx_hash, 
    t.tx_index,
    t.address_interacted_with,
    t.trace_address
FROM 
transactions t 
INNER JOIN 
dao_tmp dt 
    ON t.dao_wallet_address = dt.dao_wallet_address
LEFT JOIN 
`tokens`.`erc20` er 
    ON t.token = er.contract_address
    AND er.blockchain = 'polygon'
LEFT JOIN 
`prices`.`usd` p 
    ON p.minute = date_trunc('minute', t.block_time)
    AND p.contract_address = t.token
    AND p.blockchain = 'polygon'
    
    AND p.minute >= '2021-09-01'
    
    
LEFT JOIN 
`dex`.`prices` dp 
    ON dp.hour = date_trunc('hour', t.block_time)
    AND dp.contract_address = t.token
    AND dp.blockchain = 'polygon'
    AND dp.hour >= '2021-09-01'
    