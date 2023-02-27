



SELECT *
FROM (
    
    SELECT
        blockchain,
        address,
        name,
        case when category = 'ENS' then 'social' else category end as category,
        contributor,
        source,
        created_at,
        updated_at,
        model_name,
        label_type
    FROM `labels`.`ens`
    
    
)