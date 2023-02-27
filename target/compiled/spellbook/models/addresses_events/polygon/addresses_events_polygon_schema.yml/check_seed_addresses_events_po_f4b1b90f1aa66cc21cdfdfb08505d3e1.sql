
    
    

    with matched_records as (
        select
            seed.blockchain as seed_blockchain,
            model_sample.blockchain as model_blockchain,
            
            seed.address as seed_address,
            model_sample.address as model_address,
            
            seed.first_funded_by as seed_first_funded_by,
            model_sample.first_funded_by as model_first_funded_by ,
            
            seed.block_number as seed_block_number,
            model_sample.block_number as model_block_number ,
            
            seed.tx_hash as seed_tx_hash,
            model_sample.tx_hash as model_tx_hash 
            from `test_data`.`first_funded_by_seed` seed
        left join (
            select
                model.blockchain,
                
                model.address,
                
                model.first_funded_by ,
                
                model.block_number ,
                
                model.tx_hash 
                from  `test_data`.`first_funded_by_seed` seed
            inner join `addresses_events_polygon`.`first_funded_by` model
                ON 1=1
                    AND seed.blockchain = model.blockchain
                    
                    AND seed.address = model.address
                    ) model_sample
        ON 1=1
            AND seed.blockchain = model_sample.blockchain
            
            AND seed.address = model_sample.address
            WHERE 1=1
                       AND seed.blockchain = 'polygon' 
                  ),

    -- check if the matching columns return singular results
    matching_count_test as (
        select
            'matched records count' as test_description,
            count(model_blockchain) as `result_model`,
            1 as `expected_seed`,
            seed_blockchain as blockchain,
            
            seed_address as address
            from matched_records
        GROUP BY
            seed_blockchain ,
            
            seed_address 
            ) ,

    equality_tests as
    (
        select
            'equality test: first_funded_by' as test_description
            ,test.*
        from (
            select
                model_first_funded_by as `result_model`,
                seed_first_funded_by as `expected_seed`,
                seed_blockchain ,
                
                seed_address 
                from matched_records
        ) test
        UNION ALL
        
        select
            'equality test: block_number' as test_description
            ,test.*
        from (
            select
                model_block_number as `result_model`,
                seed_block_number as `expected_seed`,
                seed_blockchain ,
                
                seed_address 
                from matched_records
        ) test
        UNION ALL
        
        select
            'equality test: tx_hash' as test_description
            ,test.*
        from (
            select
                model_tx_hash as `result_model`,
                seed_tx_hash as `expected_seed`,
                seed_blockchain ,
                
                seed_address 
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


