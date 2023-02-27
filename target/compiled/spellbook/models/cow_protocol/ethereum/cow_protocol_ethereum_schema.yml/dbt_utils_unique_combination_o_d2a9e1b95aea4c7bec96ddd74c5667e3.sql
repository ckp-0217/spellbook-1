





with validation_errors as (

    select
        tx_hash, order_uid, evt_index
    from `cow_protocol_ethereum`.`trades`
    group by tx_hash, order_uid, evt_index
    having count(*) > 1

)

select *
from validation_errors


