





with validation_errors as (

    select
        block_date, blockchain, project, version, tx_hash, evt_index, trace_address
    from `hashflow_ethereum`.`trades`
    group by block_date, blockchain, project, version, tx_hash, evt_index, trace_address
    having count(*) > 1

)

select *
from validation_errors


