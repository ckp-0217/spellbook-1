



SELECT *
FROM (
    
    SELECT
        *
    FROM `labels`.`multisig_ethereum`
    
    UNION ALL
    
    
    SELECT
        *
    FROM `labels`.`dao_framework`
    
    
)