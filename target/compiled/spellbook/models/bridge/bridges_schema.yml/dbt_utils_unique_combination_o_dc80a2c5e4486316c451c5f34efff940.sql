





with validation_errors as (

    select
        block_date, blockchain, tx_hash, evt_index, transfer_id
    from `bridge`.`flows`
    group by block_date, blockchain, tx_hash, evt_index, transfer_id
    having count(*) > 1

)

select *
from validation_errors


