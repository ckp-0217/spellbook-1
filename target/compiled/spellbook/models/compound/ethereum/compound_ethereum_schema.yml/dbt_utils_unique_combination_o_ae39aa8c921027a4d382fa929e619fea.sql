





with validation_errors as (

    select
        block_date, evt_block_number, evt_index
    from `compound_v2_ethereum`.`supply`
    group by block_date, evt_block_number, evt_index
    having count(*) > 1

)

select *
from validation_errors


