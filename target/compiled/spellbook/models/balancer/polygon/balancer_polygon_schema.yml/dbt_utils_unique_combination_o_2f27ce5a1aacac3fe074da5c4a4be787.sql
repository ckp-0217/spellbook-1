





with validation_errors as (

    select
        evt_tx_hash, evt_index, block_date
    from `balancer_v2_polygon`.`transfers_bpt`
    group by evt_tx_hash, evt_index, block_date
    having count(*) > 1

)

select *
from validation_errors


