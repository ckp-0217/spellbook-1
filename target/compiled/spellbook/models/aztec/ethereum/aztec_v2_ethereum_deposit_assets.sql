

WITH 

assets_added as (
        SELECT
            CAST('0' AS VARCHAR(5)) as asset_id,
            '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee' as asset_address,
            null as asset_gas_limit,
            null as date_added

        UNION
        
        SELECT 
            assetId as asset_id,
            assetAddress as asset_address,
            assetGasLimit as asset_gas_limit,
            evt_block_time as date_added
        FROM 
        `aztec_v2_ethereum`.`RollupProcessor_evt_AssetAdded`
)

SELECT 
    a.*,
    t.symbol,
    t.decimals
FROM 
assets_added a
LEFT JOIN
`tokens`.`erc20` t 
    ON a.asset_address = t.contract_address
    AND t.blockchain = 'ethereum'
;