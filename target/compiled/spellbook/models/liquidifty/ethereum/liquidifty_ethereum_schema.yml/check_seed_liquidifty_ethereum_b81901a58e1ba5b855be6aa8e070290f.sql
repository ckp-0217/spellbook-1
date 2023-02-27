
    
    

    with matched_records as (
        select
            seed.block_number as seed_block_number,
            model_sample.block_number as model_block_number,
            
            seed.version as seed_version,
            model_sample.version as model_version,
            
            seed.tx_hash as seed_tx_hash,
            model_sample.tx_hash as model_tx_hash,
            
            seed.token_id as seed_token_id,
            model_sample.token_id as model_token_id,
            
            seed.amount_original as seed_amount_original,
            model_sample.amount_original as model_amount_original ,
            
            seed.buyer as seed_buyer,
            model_sample.buyer as model_buyer ,
            
            seed.seller as seed_seller,
            model_sample.seller as model_seller 
            from `test_data`.`liquidifty_ethereum_nft_trades_samples` seed
        left join (
            select
                model.block_number,
                
                model.version,
                
                model.tx_hash,
                
                model.token_id,
                
                model.amount_original ,
                
                model.buyer ,
                
                model.seller 
                from  `test_data`.`liquidifty_ethereum_nft_trades_samples` seed
            inner join `liquidifty_ethereum`.`trades` model
                ON 1=1
                    AND seed.block_number = model.block_number
                    
                    AND seed.version = model.version
                    
                    AND seed.tx_hash = model.tx_hash
                    
                    AND seed.token_id = model.token_id
                    ) model_sample
        ON 1=1
            AND seed.block_number = model_sample.block_number
            
            AND seed.version = model_sample.version
            
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
            
            seed_version as version,
            
            seed_tx_hash as tx_hash,
            
            seed_token_id as token_id
            from matched_records
        GROUP BY
            seed_block_number ,
            
            seed_version ,
            
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
                
                seed_version ,
                
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
                seed_block_number ,
                
                seed_version ,
                
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
                seed_block_number ,
                
                seed_version ,
                
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


