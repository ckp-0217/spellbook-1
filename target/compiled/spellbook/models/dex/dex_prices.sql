

WITH

dex_trades as (
    SELECT 
        d.token_bought_address as contract_address, 
        COALESCE(d.amount_usd/d.token_bought_amount, d.amount_usd/(d.token_bought_amount_raw/POW(10, er.decimals))) as price, 
        d.block_time, 
        d.blockchain
    FROM `dex`.`trades` d 
    LEFT JOIN `tokens`.`erc20` er 
        ON d.token_bought_address = er.contract_address
        AND d.blockchain = er.blockchain
    WHERE d.amount_usd > 0 
        AND d.token_bought_amount_raw > 0 
        

    UNION ALL

    SELECT 
        d.token_sold_address as contract_address, 
        COALESCE(d.amount_usd/d.token_sold_amount, d.amount_usd/(d.token_sold_amount_raw/POW(10, er.decimals))) as price, 
        d.block_time, 
        d.blockchain
    FROM `dex`.`trades` d 
    LEFT JOIN `tokens`.`erc20` er 
        ON d.token_sold_address = er.contract_address
        AND d.blockchain = er.blockchain
    WHERE d.amount_usd > 0 
        AND d.token_bought_amount_raw > 0 
        
)

SELECT 
    TRY_CAST(date_trunc('day', hour) as date) as day, -- for partitioning 
    * 
FROM 
(
    SELECT 
        date_trunc('hour', block_time) as hour, 
        contract_address,
        blockchain,
        (PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price)) AS median_price,
        COUNT(price) as sample_size 
    FROM dex_trades
    GROUP BY 1, 2, 3
    HAVING COUNT(price) >= 5 
) tmp
;