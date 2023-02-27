

SELECT 'ethereum' as blockchain,
       address, 
       concat(upper(substring(namespace,1,1)),substring(namespace,2)) || ': ' || name as name,
       'contracts' as category,
       'soispoke' as contributor,
       'query' AS source,
       date('2022-09-26') as created_at,
       now() as modified_at,
        'contracts' as model_name,
       'identifier' as label_type
FROM `ethereum`.`contracts` 
UNION 
SELECT 'gnosis' as blockchain,
       address, 
       concat(upper(substring(namespace,1,1)),substring(namespace,2)) || ': ' || name as name,
       'contracts' as category,
       'soispoke' as contributor,
       'query' AS source,
       date('2022-09-26') as created_at,
       now() as modified_at,
        'contracts' as model_name,
       'identifier' as label_type
FROM `gnosis`.`contracts` 
UNION 
SELECT 'avalanche_c' as blockchain,
       address, 
       concat(upper(substring(namespace,1,1)),substring(namespace,2)) || ': ' || name as name,
       'contracts' as category,
       'soispoke' as contributor,
       'query' AS source,
       date('2022-09-26') as created_at,
       now() as modified_at,
        'contracts' as model_name,
       'identifier' as label_type
FROM `avalanche_c`.`contracts` 
UNION 
SELECT 'arbitrum' as blockchain,
       address, 
       concat(upper(substring(namespace,1,1)),substring(namespace,2)) || ': ' || name as name,
       'contracts' as category,
       'soispoke' as contributor,
       'query' AS source,
       date('2022-09-26') as created_at,
       now() as modified_at,
       'contracts' as model_name,
       'identifier' as label_type
FROM `arbitrum`.`contracts` 
UNION 
SELECT 'bnb' as blockchain,
       address, 
       concat(upper(substring(namespace,1,1)),substring(namespace,2)) || ': ' || name as name,
       'contracts' as category,
       'soispoke' as contributor,
       'query' AS source,
       date('2022-09-26') as created_at,
       now() as modified_at,
       'contracts' as model_name,
       'identifier' as label_type
FROM `bnb`.`contracts` 
UNION 
SELECT 'optimism' as blockchain,
       address, 
       concat(upper(substring(namespace,1,1)),substring(namespace,2)) || ': ' || name as name,
       'contracts' as category,
       'soispoke' as contributor,
       'query' AS source,
       date('2022-09-26') as created_at,
       now() as modified_at,
       'contracts' as model_name,
       'identifier' as label_type
FROM `optimism`.`contracts` 
UNION 
SELECT 'fantom' as blockchain,
       address, 
       concat(upper(substring(namespace,1,1)),substring(namespace,2)) || ': ' || name as name,
       'contracts' as category,
       'Henrystats' as contributor,
       'query' AS source,
       date('2022-12-18') as created_at,
       now() as modified_at,
       'contracts' as model_name,
       'identifier' as label_type
FROM `fantom`.`contracts` 
UNION 
SELECT 'polygon' as blockchain,
       address, 
       concat(upper(substring(namespace,1,1)),substring(namespace,2)) || ': ' || name as name,
       'contracts' as category,
       'Henrystats' as contributor,
       'query' AS source,
       date('2023-01-27') as created_at,
       now() as modified_at,
       'contracts' as model_name,
       'identifier' as label_type
FROM `polygon`.`contracts`