
    
    

    with matched_records as (
        select
            seed.blockchain as seed_blockchain,
            model_sample.blockchain as model_blockchain,
            
            seed.block_number as seed_block_number,
            model_sample.block_number as model_block_number,
            
            seed.proxy_address as seed_proxy_address,
            model_sample.proxy_address as model_proxy_address,
            
            seed.underlying_token_address as seed_underlying_token_address,
            model_sample.underlying_token_address as model_underlying_token_address,
            
            seed.aggregator_address as seed_aggregator_address,
            model_sample.aggregator_address as model_aggregator_address ,
            
            seed.feed_name as seed_feed_name,
            model_sample.feed_name as model_feed_name ,
            
            seed.oracle_price as seed_oracle_price,
            model_sample.oracle_price as model_oracle_price 
            from `test_data`.`chainlink_get_price_seed` seed
        left join (
            select
                model.blockchain,
                
                model.block_number,
                
                model.proxy_address,
                
                model.underlying_token_address,
                
                model.aggregator_address ,
                
                model.feed_name ,
                
                model.oracle_price 
                from  `test_data`.`chainlink_get_price_seed` seed
            inner join `chainlink_optimism`.`price_feeds` model
                ON 1=1
                    AND seed.blockchain = model.blockchain
                    
                    AND seed.block_number = model.block_number
                    
                    AND seed.proxy_address = model.proxy_address
                    
                    AND seed.underlying_token_address = model.underlying_token_address
                    ) model_sample
        ON 1=1
            AND seed.blockchain = model_sample.blockchain
            
            AND seed.block_number = model_sample.block_number
            
            AND seed.proxy_address = model_sample.proxy_address
            
            AND seed.underlying_token_address = model_sample.underlying_token_address
            WHERE 1=1
                       AND seed.blockchain = 'optimism' 
                  ),

    -- check if the matching columns return singular results
    matching_count_test as (
        select
            'matched records count' as test_description,
            count(model_blockchain) as `result_model`,
            1 as `expected_seed`,
            seed_blockchain as blockchain,
            
            seed_block_number as block_number,
            
            seed_proxy_address as proxy_address,
            
            seed_underlying_token_address as underlying_token_address
            from matched_records
        GROUP BY
            seed_blockchain ,
            
            seed_block_number ,
            
            seed_proxy_address ,
            
            seed_underlying_token_address 
            ) ,

    equality_tests as
    (
        select
            'equality test: aggregator_address' as test_description
            ,test.*
        from (
            select
                model_aggregator_address as `result_model`,
                seed_aggregator_address as `expected_seed`,
                seed_blockchain ,
                
                seed_block_number ,
                
                seed_proxy_address ,
                
                seed_underlying_token_address 
                from matched_records
        ) test
        UNION ALL
        
        select
            'equality test: feed_name' as test_description
            ,test.*
        from (
            select
                model_feed_name as `result_model`,
                seed_feed_name as `expected_seed`,
                seed_blockchain ,
                
                seed_block_number ,
                
                seed_proxy_address ,
                
                seed_underlying_token_address 
                from matched_records
        ) test
        UNION ALL
        
        select
            'equality test: oracle_price' as test_description
            ,test.*
        from (
            select
                model_oracle_price as `result_model`,
                seed_oracle_price as `expected_seed`,
                seed_blockchain ,
                
                seed_block_number ,
                
                seed_proxy_address ,
                
                seed_underlying_token_address 
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


