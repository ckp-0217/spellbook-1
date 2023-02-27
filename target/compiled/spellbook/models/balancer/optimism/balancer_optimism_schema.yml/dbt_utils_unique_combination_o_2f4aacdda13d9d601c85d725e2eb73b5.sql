





with validation_errors as (

    select
        block_number, tx_hash, index
    from `balancer_v2_optimism`.`pools_fees`
    group by block_number, tx_hash, index
    having count(*) > 1

)

select *
from validation_errors


