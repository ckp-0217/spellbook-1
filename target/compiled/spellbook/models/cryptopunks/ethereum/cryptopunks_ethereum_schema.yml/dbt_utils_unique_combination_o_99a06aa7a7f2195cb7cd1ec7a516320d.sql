





with validation_errors as (

    select
        evt_block_time_week, punk_id, evt_tx_hash, evt_index
    from `cryptopunks_ethereum`.`punk_transfers`
    group by evt_block_time_week, punk_id, evt_tx_hash, evt_index
    having count(*) > 1

)

select *
from validation_errors


