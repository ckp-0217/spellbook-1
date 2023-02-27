





with validation_errors as (

    select
        block_date, evt_tx_hash, evt_index
    from `jarvis_network_polygon`.`all_transactions`
    group by block_date, evt_tx_hash, evt_index
    having count(*) > 1

)

select *
from validation_errors


