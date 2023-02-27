



WITH 

dao_tmp as (
        SELECT 
            blockchain, 
            dao_creator_tool, 
            dao, 
            dao_wallet_address
        FROM 
        `dao`.`addresses_ethereum`
        WHERE dao_wallet_address IS NOT NULL
        AND dao_wallet_address NOT IN ('0x0000000000000000000000000000000000000001', '0x000000000000000000000000000000000000dead')
), 

transactions as (
        SELECT 
            block_time, 
            tx_hash, 
            LOWER('0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee') as token, 
            value as value, 
            to as dao_wallet_address, 
            'tx_in' as tx_type, 
            tx_index,
            COALESCE(from, '') as address_interacted_with,
            trace_address
        FROM 
        `ethereum`.`traces`
        
        WHERE block_time >= '2018-10-27'
        
        
        AND to IN (SELECT dao_wallet_address FROM dao_tmp)
        AND (LOWER(call_type) NOT IN ('delegatecall', 'callcode', 'staticcall') or call_type IS NULL)
        AND success = true 
        AND CAST(value as decimal(38,0)) != 0 

        UNION ALL 

        SELECT 
            block_time, 
            tx_hash, 
            LOWER('0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee') as token, 
            value as value, 
            from as dao_wallet_address, 
            'tx_out' as tx_type,
            tx_index,
            COALESCE(to, '') as address_interacted_with,
            trace_address
        FROM 
        `ethereum`.`traces`
        
        WHERE block_time >= '2018-10-27'
        
        
        AND from IN (SELECT dao_wallet_address FROM dao_tmp)
        AND (LOWER(call_type) NOT IN ('delegatecall', 'callcode', 'staticcall') or call_type IS NULL)
        AND success = true 
        AND CAST(value as decimal(38,0)) != 0 
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
    'ETH' asset,
    CAST(t.value AS DECIMAL(38,0)) as raw_value, 
    t.value/POW(10, 18) as value, 
    t.value/POW(10, 18) * COALESCE(p.price, dp.median_price) as usd_value, 
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
`prices`.`usd` p 
    ON p.minute = date_trunc('minute', t.block_time)
    AND p.symbol = 'WETH'
    AND p.blockchain = 'ethereum'
    
    AND p.minute >= '2018-10-27'
    
    
LEFT JOIN 
`dex`.`prices` dp 
    ON dp.hour = date_trunc('hour', t.block_time)
    AND dp.contract_address = LOWER('0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2')
    AND dp.blockchain = 'ethereum'
    AND dp.hour >= '2018-10-27'
    