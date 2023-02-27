

    with matched_records as (
        select
            seed.block_date as seed_block_date,
            model_sample.block_date as model_block_date,
            
            seed.blockchain as seed_blockchain,
            model_sample.blockchain as model_blockchain,
            
            seed.project as seed_project,
            model_sample.project as model_project,
            
            seed.version as seed_version,
            model_sample.version as model_version,
            
            seed.tx_hash as seed_tx_hash,
            model_sample.tx_hash as model_tx_hash,
            
            seed.market_address as seed_market_address,
            model_sample.market_address as model_market_address ,
            
            seed.trade as seed_trade,
            model_sample.trade as model_trade 
            from `test_data`.`perpetual_trades_seed` seed
        left join (
            select
                model.block_date,
                
                model.blockchain,
                
                model.project,
                
                model.version,
                
                model.tx_hash,
                
                model.market_address ,
                
                model.trade 
                from  `test_data`.`perpetual_trades_seed` seed
            inner join `gmx_avalanche_c`.`perpetual_trades` model
                ON 1=1
                    AND seed.block_date = model.block_date
                    
                    AND seed.blockchain = model.blockchain
                    
                    AND seed.project = model.project
                    
                    AND seed.version = model.version
                    
                    AND seed.tx_hash = model.tx_hash
                    ) model_sample
        ON 1=1
            AND seed.block_date = model_sample.block_date
            
            AND seed.blockchain = model_sample.blockchain
            
            AND seed.project = model_sample.project
            
            AND seed.version = model_sample.version
            
            AND seed.tx_hash = model_sample.tx_hash
            WHERE 1=1
                       AND seed.blockchain = 'avalanche_c' 
                  
                       AND seed.project = 'gmx' 
                  
                       AND seed.version = '1' 
                  ),

    -- check if the matching columns return singular results
    matching_count_test as (
        select
            'matched records count' as test_description,
            count(model_block_date) as `result_model`,
            1 as `expected_seed`,
            seed_block_date as block_date,
            
            seed_blockchain as blockchain,
            
            seed_project as project,
            
            seed_version as version,
            
            seed_tx_hash as tx_hash
            from matched_records
        GROUP BY
            seed_block_date ,
            
            seed_blockchain ,
            
            seed_project ,
            
            seed_version ,
            
            seed_tx_hash 
            ) ,

    equality_tests as
    (
        select
            'equality test: market_address' as test_description
            ,test.*
        from (
            select
                model_market_address as `result_model`,
                seed_market_address as `expected_seed`,
                seed_block_date ,
                
                seed_blockchain ,
                
                seed_project ,
                
                seed_version ,
                
                seed_tx_hash 
                from matched_records
        ) test
        UNION ALL
        
        select
            'equality test: trade' as test_description
            ,test.*
        from (
            select
                model_trade as `result_model`,
                seed_trade as `expected_seed`,
                seed_block_date ,
                
                seed_blockchain ,
                
                seed_project ,
                
                seed_version ,
                
                seed_tx_hash 
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


