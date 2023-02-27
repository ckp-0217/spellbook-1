





with validation_errors as (

    select
        block_number, wallet_address
    from `balancer_ethereum`.`vebal_slopes`
    group by block_number, wallet_address
    having count(*) > 1

)

select *
from validation_errors


