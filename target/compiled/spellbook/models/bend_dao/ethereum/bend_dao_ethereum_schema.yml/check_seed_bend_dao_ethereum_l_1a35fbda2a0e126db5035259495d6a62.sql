
    
    

    with matched_records as (
        select
            seed.block_number as seed_block_number,
            model_sample.block_number as model_block_number,
            
            seed.tx_hash as seed_tx_hash,
            model_sample.tx_hash as model_tx_hash,
            
            seed.token_id as seed_token_id,
            model_sample.token_id as model_token_id,
            
            seed.amount_original as seed_amount_original,
            model_sample.amount_original as model_amount_original ,
            
            seed.evt_type as seed_evt_type,
            model_sample.evt_type as model_evt_type ,
            
            seed.address as seed_address,
            model_sample.address as model_address 
            from `test_data`.`bend_dao_nft_lending` seed
        left join (
            select
                model.block_number,
                
                model.tx_hash,
                
                model.token_id,
                
                model.amount_original ,
                
                model.evt_type ,
                
                model.address 
                from  `test_data`.`bend_dao_nft_lending` seed
            inner join `bend_dao_ethereum`.`lending` model
                ON 1=1
                    AND seed.block_number = model.block_number
                    
                    AND seed.tx_hash = model.tx_hash
                    
                    AND seed.token_id = model.token_id
                    ) model_sample
        ON 1=1
            AND seed.block_number = model_sample.block_number
            
            AND seed.tx_hash = model_sample.tx_hash
            
            AND seed.token_id = model_sample.token_id
            WHERE 1=1),

    -- check if the matching columns return singular results
    matching_count_test as (
        select
            'matched records count' as test_description,
            count(model_block_number) as `result_model`,
            1 as `expected_seed`,
            seed_block_number as block_number,
            
            seed_tx_hash as tx_hash,
            
            seed_token_id as token_id
            from matched_records
        GROUP BY
            seed_block_number ,
            
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
                seed_block_number ,
                
                seed_tx_hash ,
                
                seed_token_id 
                from matched_records
        ) test
        UNION ALL
        
        select
            'equality test: evt_type' as test_description
            ,test.*
        from (
            select
                model_evt_type as `result_model`,
                seed_evt_type as `expected_seed`,
                seed_block_number ,
                
                seed_tx_hash ,
                
                seed_token_id 
                from matched_records
        ) test
        UNION ALL
        
        select
            'equality test: address' as test_description
            ,test.*
        from (
            select
                model_address as `result_model`,
                seed_address as `expected_seed`,
                seed_block_number ,
                
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


