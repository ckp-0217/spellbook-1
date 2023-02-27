



WITH
    signatures as (
        

            SELECT
                abi,
                created_at,
                id,
                signature,
                type,
                concat(id, signature, type) as unique_signature_id
            FROM `ethereum`.`signatures`
            
            

            
            union all
            

        

            SELECT
                abi,
                created_at,
                id,
                signature,
                type,
                concat(id, signature, type) as unique_signature_id
            FROM `optimism`.`signatures`
            
            

            
            union all
            

        

            SELECT
                abi,
                created_at,
                id,
                signature,
                type,
                concat(id, signature, type) as unique_signature_id
            FROM `arbitrum`.`signatures`
            
            

            
            union all
            

        

            SELECT
                abi,
                created_at,
                id,
                signature,
                type,
                concat(id, signature, type) as unique_signature_id
            FROM `avalanche_c`.`signatures`
            
            

            
            union all
            

        

            SELECT
                abi,
                created_at,
                id,
                signature,
                type,
                concat(id, signature, type) as unique_signature_id
            FROM `polygon`.`signatures`
            
            

            
            union all
            

        

            SELECT
                abi,
                created_at,
                id,
                signature,
                type,
                concat(id, signature, type) as unique_signature_id
            FROM `bnb`.`signatures`
            
            

            
            union all
            

        

            SELECT
                abi,
                created_at,
                id,
                signature,
                type,
                concat(id, signature, type) as unique_signature_id
            FROM `gnosis`.`signatures`
            
            

            
            union all
            

        

            SELECT
                abi,
                created_at,
                id,
                signature,
                type,
                concat(id, signature, type) as unique_signature_id
            FROM `fantom`.`signatures`
            
            

            

        
    )

    SELECT
    *
    FROM (
        SELECT 
            id
            , signature
            , abi
            , type
            , created_at
            , date_trunc('month',created_at) as created_at_month
            , unique_signature_id 
            , row_number() over (partition by unique_signature_id order by created_at desc) recency
        FROM signatures
    ) a
    WHERE recency = 1
    