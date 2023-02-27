
    
    

    with matched_records as (
        select
            seed.evt_tx_hash as seed_evt_tx_hash,
            model_sample.evt_tx_hash as model_evt_tx_hash,
            
            seed.evt_index as seed_evt_index,
            model_sample.evt_index as model_evt_index,
            
            seed.block_date as seed_block_date,
            model_sample.block_date as model_block_date,
            
            seed.contract_address as seed_contract_address,
            model_sample.contract_address as model_contract_address ,
            
            seed.evt_block_number as seed_evt_block_number,
            model_sample.evt_block_number as model_evt_block_number ,
            
            seed.from as seed_from,
            model_sample.from as model_from ,
            
            seed.to as seed_to,
            model_sample.to as model_to 
            from `test_data`.`balancer_transfers_bpt_seed` seed
        left join (
            select
                model.evt_tx_hash,
                
                model.evt_index,
                
                model.block_date,
                
                model.contract_address ,
                
                model.evt_block_number ,
                
                model.from ,
                
                model.to 
                from  `test_data`.`balancer_transfers_bpt_seed` seed
            inner join `balancer_v2_optimism`.`transfers_bpt` model
                ON 1=1
                    AND seed.evt_tx_hash = model.evt_tx_hash
                    
                    AND seed.evt_index = model.evt_index
                    
                    AND seed.block_date = model.block_date
                    ) model_sample
        ON 1=1
            AND seed.evt_tx_hash = model_sample.evt_tx_hash
            
            AND seed.evt_index = model_sample.evt_index
            
            AND seed.block_date = model_sample.block_date
            WHERE 1=1
                       AND seed.blockchain = 'optimism' 
                  ),

    -- check if the matching columns return singular results
    matching_count_test as (
        select
            'matched records count' as test_description,
            count(model_evt_tx_hash) as `result_model`,
            1 as `expected_seed`,
            seed_evt_tx_hash as evt_tx_hash,
            
            seed_evt_index as evt_index,
            
            seed_block_date as block_date
            from matched_records
        GROUP BY
            seed_evt_tx_hash ,
            
            seed_evt_index ,
            
            seed_block_date 
            ) ,

    equality_tests as
    (
        select
            'equality test: contract_address' as test_description
            ,test.*
        from (
            select
                model_contract_address as `result_model`,
                seed_contract_address as `expected_seed`,
                seed_evt_tx_hash ,
                
                seed_evt_index ,
                
                seed_block_date 
                from matched_records
        ) test
        UNION ALL
        
        select
            'equality test: evt_block_number' as test_description
            ,test.*
        from (
            select
                model_evt_block_number as `result_model`,
                seed_evt_block_number as `expected_seed`,
                seed_evt_tx_hash ,
                
                seed_evt_index ,
                
                seed_block_date 
                from matched_records
        ) test
        UNION ALL
        
        select
            'equality test: from' as test_description
            ,test.*
        from (
            select
                model_from as `result_model`,
                seed_from as `expected_seed`,
                seed_evt_tx_hash ,
                
                seed_evt_index ,
                
                seed_block_date 
                from matched_records
        ) test
        UNION ALL
        
        select
            'equality test: to' as test_description
            ,test.*
        from (
            select
                model_to as `result_model`,
                seed_to as `expected_seed`,
                seed_evt_tx_hash ,
                
                seed_evt_index ,
                
                seed_block_date 
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


