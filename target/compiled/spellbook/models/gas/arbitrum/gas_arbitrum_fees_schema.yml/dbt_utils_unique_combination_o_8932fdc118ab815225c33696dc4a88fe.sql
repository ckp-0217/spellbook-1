





with validation_errors as (

    select
        block_number, tx_hash
    from `gas_arbitrum`.`fees`
    group by block_number, tx_hash
    having count(*) > 1

)

select *
from validation_errors


