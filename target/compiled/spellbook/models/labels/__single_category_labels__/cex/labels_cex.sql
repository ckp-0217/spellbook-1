

SELECT * FROM `labels`.`cex_ethereum`

UNION All

SELECT * FROM `labels`.`cex_bnb`

UNION All

-- add address list from CEXs
SELECT 
"optimism", address, distinct_name, 'cex', 'msilb7','static','2022-10-10'::timestamp,now(),'cex_optimism','identifier'
FROM `addresses_optimism`.`cex`

UNION All

SELECT * FROM `labels`.`cex_fantom`