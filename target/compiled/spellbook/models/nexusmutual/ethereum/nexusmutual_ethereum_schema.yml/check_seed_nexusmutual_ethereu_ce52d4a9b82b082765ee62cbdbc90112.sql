
    
    

    with matched_records as (
        select
            seed.product_contract_address as seed_product_contract_address,
            model_sample.product_contract_address as model_product_contract_address,
            
            seed.product_name as seed_product_name,
            model_sample.product_name as model_product_name ,
            
            seed.product_type as seed_product_type,
            model_sample.product_type as model_product_type ,
            
            seed.syndicate as seed_syndicate,
            model_sample.syndicate as model_syndicate 
            from `test_data`.`nexusmutual_ethereum_product_information_seed` seed
        left join (
            select
                model.product_contract_address,
                
                model.product_name ,
                
                model.product_type ,
                
                model.syndicate 
                from  `test_data`.`nexusmutual_ethereum_product_information_seed` seed
            inner join `nexusmutual_ethereum`.`product_information` model
                ON 1=1
                    AND seed.product_contract_address = model.product_contract_address
                    ) model_sample
        ON 1=1
            AND seed.product_contract_address = model_sample.product_contract_address
            WHERE 1=1),

    -- check if the matching columns return singular results
    matching_count_test as (
        select
            'matched records count' as test_description,
            count(model_product_contract_address) as `result_model`,
            1 as `expected_seed`,
            seed_product_contract_address as product_contract_address
            from matched_records
        GROUP BY
            seed_product_contract_address 
            ) ,

    equality_tests as
    (
        select
            'equality test: product_name' as test_description
            ,test.*
        from (
            select
                model_product_name as `result_model`,
                seed_product_name as `expected_seed`,
                seed_product_contract_address 
                from matched_records
        ) test
        UNION ALL
        
        select
            'equality test: product_type' as test_description
            ,test.*
        from (
            select
                model_product_type as `result_model`,
                seed_product_type as `expected_seed`,
                seed_product_contract_address 
                from matched_records
        ) test
        UNION ALL
        
        select
            'equality test: syndicate' as test_description
            ,test.*
        from (
            select
                model_syndicate as `result_model`,
                seed_syndicate as `expected_seed`,
                seed_product_contract_address 
                from matched_records
        ) test)


    select * from (
        select *
        from matching_count_test
        union all
        select *
        from equality_tests
    ) all
    where `result_model` != `expected_seed`


