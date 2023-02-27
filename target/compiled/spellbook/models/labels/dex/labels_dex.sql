



SELECT *
FROM (
    
    SELECT
        *
    FROM `labels`.`sandwich_attackers`
    
    UNION ALL
    
    
    SELECT
        *
    FROM `labels`.`dex_aggregator_traders`
    
    UNION ALL
    
    
    SELECT
        *
    FROM `labels`.`arbitrage_traders`
    
    UNION ALL
    
    
    SELECT
        *
    FROM `labels`.`dex_traders`
    
    UNION ALL
    
    
    SELECT
        *
    FROM `labels`.`trader_platforms`
    
    UNION ALL
    
    
    SELECT
        *
    FROM `labels`.`average_trade_values`
    
    UNION ALL
    
    
    SELECT
        *
    FROM `labels`.`trader_age`
    
    UNION ALL
    
    
    SELECT
        *
    FROM `labels`.`trader_dex_diversity`
    
    UNION ALL
    
    
    SELECT
        *
    FROM `labels`.`trader_frequencies`
    
    UNION ALL
    
    
    SELECT
        *
    FROM `labels`.`trader_portfolios`
    
    
)