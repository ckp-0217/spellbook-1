





with validation_errors as (

    select
        block_date, evt_tx_hash, evt_index
    from `nexusmutual_ethereum`.`trades`
    group by block_date, evt_tx_hash, evt_index
    having count(*) > 1

)

select *
from validation_errors


