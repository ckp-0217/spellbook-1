



SELECT *
FROM (
    
    SELECT
        blockchain,
        hour,
        block_date,
        feed_name,
        proxy_address,
        aggregator_address,
        underlying_token_address, 
        oracle_price_avg,
        underlying_token_price_avg
    FROM `chainlink_optimism`.`price_feeds_hourly`
    
    UNION ALL
    
    
    SELECT
        blockchain,
        hour,
        block_date,
        feed_name,
        proxy_address,
        aggregator_address,
        underlying_token_address, 
        oracle_price_avg,
        underlying_token_price_avg
    FROM `chainlink_polygon`.`price_feeds_hourly`
    
    UNION ALL
    
    
    SELECT
        blockchain,
        hour,
        block_date,
        feed_name,
        proxy_address,
        aggregator_address,
        underlying_token_address, 
        oracle_price_avg,
        underlying_token_price_avg
    FROM `chainlink_bnb`.`price_feeds_hourly`
    
    
)
;