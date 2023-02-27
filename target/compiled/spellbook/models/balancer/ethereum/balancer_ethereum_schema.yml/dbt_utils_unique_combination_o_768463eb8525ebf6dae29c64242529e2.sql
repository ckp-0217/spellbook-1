





with validation_errors as (

    select
        day, wallet_address
    from `balancer_ethereum`.`vebal_balances_day`
    group by day, wallet_address
    having count(*) > 1

)

select *
from validation_errors


