

    with matched_records as (
        select
            seed.pool as seed_pool,
            model_sample.pool as model_pool,
            
            seed.blockchain as seed_blockchain,
            model_sample.blockchain as model_blockchain,
            
            seed.project as seed_project,
            model_sample.project as model_project,
            
            seed.version as seed_version,
            model_sample.version as model_version,
            
            seed.token_type as seed_token_type,
            model_sample.token_type as model_token_type,
            
            seed.token_id as seed_token_id,
            model_sample.token_id as model_token_id,
            
            seed.token_address as seed_token_address,
            model_sample.token_address as model_token_address 
            from `test_data`.`dex_pools_seed` seed
        left join (
            select
                model.pool,
                
                model.blockchain,
                
                model.project,
                
                model.version,
                
                model.token_type,
                
                model.token_id,
                
                model.token_address 
                from  `test_data`.`dex_pools_seed` seed
            inner join `ellipsis_finance_bnb`.`pool_tokens` model
                ON 1=1
                    AND seed.pool = model.pool
                    
                    AND seed.blockchain = model.blockchain
                    
                    AND seed.project = model.project
                    
                    AND seed.version = model.version
                    
                    AND seed.token_type = model.token_type
                    
                    AND seed.token_id = model.token_id
                    ) model_sample
        ON 1=1
            AND seed.pool = model_sample.pool
            
            AND seed.blockchain = model_sample.blockchain
            
            AND seed.project = model_sample.project
            
            AND seed.version = model_sample.version
            
            AND seed.token_type = model_sample.token_type
            
            AND seed.token_id = model_sample.token_id
            WHERE 1=1
                       AND seed.blockchain = 'bnb' 
                  
                       AND seed.project = 'ellipsis_finance' 
                  
                       AND seed.version = '1' 
                  ),

    -- check if the matching columns return singular results
    matching_count_test as (
        select
            'matched records count' as test_description,
            count(model_pool) as `result_model`,
            1 as `expected_seed`,
            seed_pool as pool,
            
            seed_blockchain as blockchain,
            
            seed_project as project,
            
            seed_version as version,
            
            seed_token_type as token_type,
            
            seed_token_id as token_id
            from matched_records
        GROUP BY
            seed_pool ,
            
            seed_blockchain ,
            
            seed_project ,
            
            seed_version ,
            
            seed_token_type ,
            
            seed_token_id 
            ) ,

    equality_tests as
    (
        select
            'equality test: token_address' as test_description
            ,test.*
        from (
            select
                model_token_address as `result_model`,
                seed_token_address as `expected_seed`,
                seed_pool ,
                
                seed_blockchain ,
                
                seed_project ,
                
                seed_version ,
                
                seed_token_type ,
                
                seed_token_id 
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


