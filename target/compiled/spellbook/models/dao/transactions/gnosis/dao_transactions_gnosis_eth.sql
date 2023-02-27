



WITH 

dao_tmp as (
        SELECT 
            blockchain, 
            dao_creator_tool, 
            dao, 
            dao_wallet_address
        FROM 
        `dao`.`addresses_gnosis`
        WHERE dao_wallet_address IS NOT NULL
), 

transactions as (
        SELECT 
            block_time, 
            tx_hash, 
            LOWER('0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee') as token, 
            value as value, 
            to as dao_wallet_address, 
            'tx-in' as tx_type, 
            tx_index, 
            COALESCE(from, '') as address_interacted_with,
            trace_address
        FROM 
        `gnosis`.`traces`
        
        WHERE block_time >= '2020-05-24'
        
        
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
        `gnosis`.`traces`
        
        WHERE block_time >= '2020-05-24'
        
        
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
    'xDAI' as asset,
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
    AND p.symbol = 'WXDAI'
    AND p.blockchain = 'gnosis'
    
    AND p.minute >= '2020-05-24'
    
    
LEFT JOIN 
`dex`.`prices` dp 
    ON dp.hour = date_trunc('hour', t.block_time)
    AND dp.contract_address = LOWER('0xe91d153e0b41518a2ce8dd3d7944fa863463a97d')
    AND dp.blockchain = 'gnosis'
    AND dp.hour >= '2020-05-24'
    