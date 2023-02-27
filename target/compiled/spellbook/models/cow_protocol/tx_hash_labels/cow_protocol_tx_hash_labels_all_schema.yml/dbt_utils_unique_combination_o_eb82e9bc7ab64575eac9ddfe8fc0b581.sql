





with validation_errors as (

    select
        tx_hash, name, category, blockchain
    from `cow_protocol`.`tx_hash_labels_all`
    group by tx_hash, name, category, blockchain
    having count(*) > 1

)

select *
from validation_errors


