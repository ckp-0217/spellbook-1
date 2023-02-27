
    
    

    with matched_records as (
        select
            seed.block_time as seed_block_time,
            model_sample.block_time as model_block_time,
            
            seed.tx_hash as seed_tx_hash,
            model_sample.tx_hash as model_tx_hash,
            
            seed.token_id as seed_token_id,
            model_sample.token_id as model_token_id,
            
            seed.amount_original as seed_amount_original,
            model_sample.amount_original as model_amount_original ,
            
            seed.buyer as seed_buyer,
            model_sample.buyer as model_buyer ,
            
            seed.seller as seed_seller,
            model_sample.seller as model_seller ,
            
            seed.platform_fee_amount as seed_platform_fee_amount,
            model_sample.platform_fee_amount as model_platform_fee_amount ,
            
            seed.royalty_fee_amount as seed_royalty_fee_amount,
            model_sample.royalty_fee_amount as model_royalty_fee_amount 
            from `test_data`.`foundation_trades_samples` seed
        left join (
            select
                model.block_time,
                
                model.tx_hash,
                
                model.token_id,
                
                model.amount_original ,
                
                model.buyer ,
                
                model.seller ,
                
                model.platform_fee_amount ,
                
                model.royalty_fee_amount 
                from  `test_data`.`foundation_trades_samples` seed
            inner join `foundation_ethereum`.`events` model
                ON 1=1
                    AND seed.block_time = model.block_time
                    
                    AND seed.tx_hash = model.tx_hash
                    
                    AND seed.token_id = model.token_id
                    ) model_sample
        ON 1=1
            AND seed.block_time = model_sample.block_time
            
            AND seed.tx_hash = model_sample.tx_hash
            
            AND seed.token_id = model_sample.token_id
            WHERE 1=1),

    -- check if the matching columns return singular results
    matching_count_test as (
        select
            'matched records count' as test_description,
            count(model_block_time) as `result_model`,
            1 as `expected_seed`,
            seed_block_time as block_time,
            
            seed_tx_hash as tx_hash,
            
            seed_token_id as token_id
            from matched_records
        GROUP BY
            seed_block_time ,
            
            seed_tx_hash ,
            
            seed_token_id 
            ) ,

    equality_tests as
    (
        select
            'equality test: amount_original' as test_description
            ,test.*
        from (
            select
                model_amount_original as `result_model`,
                seed_amount_original as `expected_seed`,
                seed_block_time ,
                
                seed_tx_hash ,
                
                seed_token_id 
                from matched_records
        ) test
        UNION ALL
        
        select
            'equality test: buyer' as test_description
            ,test.*
        from (
            select
                model_buyer as `result_model`,
                seed_buyer as `expected_seed`,
                seed_block_time ,
                
                seed_tx_hash ,
                
                seed_token_id 
                from matched_records
        ) test
        UNION ALL
        
        select
            'equality test: seller' as test_description
            ,test.*
        from (
            select
                model_seller as `result_model`,
                seed_seller as `expected_seed`,
                seed_block_time ,
                
                seed_tx_hash ,
                
                seed_token_id 
                from matched_records
        ) test
        UNION ALL
        
        select
            'equality test: platform_fee_amount' as test_description
            ,test.*
        from (
            select
                model_platform_fee_amount as `result_model`,
                seed_platform_fee_amount as `expected_seed`,
                seed_block_time ,
                
                seed_tx_hash ,
                
                seed_token_id 
                from matched_records
        ) test
        UNION ALL
        
        select
            'equality test: royalty_fee_amount' as test_description
            ,test.*
        from (
            select
                model_royalty_fee_amount as `result_model`,
                seed_royalty_fee_amount as `expected_seed`,
                seed_block_time ,
                
                seed_tx_hash ,
                
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


