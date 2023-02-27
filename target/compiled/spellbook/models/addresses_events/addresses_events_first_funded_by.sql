



SELECT *
FROM (
    
    SELECT blockchain
    , address
    , first_funded_by
    , block_time
    , block_number
    , tx_hash
    FROM `addresses_events_arbitrum`.`first_funded_by`
    
    UNION ALL
    
    
    SELECT blockchain
    , address
    , first_funded_by
    , block_time
    , block_number
    , tx_hash
    FROM `addresses_events_avalanche_c`.`first_funded_by`
    
    UNION ALL
    
    
    SELECT blockchain
    , address
    , first_funded_by
    , block_time
    , block_number
    , tx_hash
    FROM `addresses_events_bnb`.`first_funded_by`
    
    UNION ALL
    
    
    SELECT blockchain
    , address
    , first_funded_by
    , block_time
    , block_number
    , tx_hash
    FROM `addresses_events_ethereum`.`first_funded_by`
    
    UNION ALL
    
    
    SELECT blockchain
    , address
    , first_funded_by
    , block_time
    , block_number
    , tx_hash
    FROM `addresses_events_fantom`.`first_funded_by`
    
    UNION ALL
    
    
    SELECT blockchain
    , address
    , first_funded_by
    , block_time
    , block_number
    , tx_hash
    FROM `addresses_events_gnosis`.`first_funded_by`
    
    UNION ALL
    
    
    SELECT blockchain
    , address
    , first_funded_by
    , block_time
    , block_number
    , tx_hash
    FROM `addresses_events_optimism`.`first_funded_by`
    
    UNION ALL
    
    
    SELECT blockchain
    , address
    , first_funded_by
    , block_time
    , block_number
    , tx_hash
    FROM `addresses_events_polygon`.`first_funded_by`
    
    
)
;