

SELECT *
FROM (
    SELECT blockchain
    , address
    , first_funded_by
    , block_time
    , block_number
    , tx_hash
    FROM `addresses_events_testnets_goerli`.`first_funded_by`
)