




WITH registered_pools AS (
    SELECT DISTINCT
        `poolAddress` AS pool_address
    FROM
        `balancer_v2_ethereum`.`Vault_evt_PoolRegistered`
)
SELECT
    logs.contract_address,
    logs.tx_hash,
    logs.tx_index,
    logs.index,
    logs.block_time,
    logs.block_number,
    bytea2numeric_v2 (SUBSTRING(logs.data FROM 32 FOR 64)) * 1 AS swap_fee_percentage
FROM
    `ethereum`.`logs`
    INNER JOIN registered_pools ON registered_pools.pool_address = logs.contract_address
WHERE logs.topic1 = '0xa9ba3ffe0b6c366b81232caab38605a0699ad5398d6cce76f91ee809e322dafc'
    
    AND logs.block_time >= '2021-04-20'
    
    
;