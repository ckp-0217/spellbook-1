





with validation_errors as (

    select
        block_date, composite_index, tx_hash
    from `hashflow_ethereum`.`raw_trades`
    group by block_date, composite_index, tx_hash
    having count(*) > 1

)

select *
from validation_errors


