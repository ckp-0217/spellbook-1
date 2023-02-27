

SELECT

    'optimism' as blockchain,
    address,
    project_name AS name,
    'project wallet' AS category,
    'msilb7' AS contributor,
    'static' AS source,
    timestamp('2023-01-28') as created_at,
    NOW() AS updated_at,
    'project_wallets' AS model_name,
    'identifier' AS label_type

FROM `addresses_optimism`.`grants_funding`
GROUP BY 1,2,3

-- UNION ALL

-- Add additional project wallet labels here