



SELECT *
FROM (
    
    SELECT
        *
    FROM `labels`.`eth_stakers`
    
    UNION ALL
    
    
    SELECT
        *
    FROM `labels`.`miners`
    
    UNION ALL
    
    
    SELECT
        *
    FROM `labels`.`system_addresses`
    
    UNION ALL
    
    
    SELECT
        *
    FROM `labels`.`validators`
    
    UNION ALL
    
    
    SELECT
        *
    FROM `labels`.`flashbots_ethereum`
    
    UNION ALL
    
    
    SELECT
        *
    FROM `labels`.`mev_ethereum`
    
    
)