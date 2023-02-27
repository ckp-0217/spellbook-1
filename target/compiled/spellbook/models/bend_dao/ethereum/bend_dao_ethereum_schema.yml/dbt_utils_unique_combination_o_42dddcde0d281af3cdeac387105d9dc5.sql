





with validation_errors as (

    select
        block_date, blockchain, project, version, evt_type, tx_hash, evt_index
    from `bend_dao_ethereum`.`lending`
    group by block_date, blockchain, project, version, evt_type, tx_hash, evt_index
    having count(*) > 1

)

select *
from validation_errors


