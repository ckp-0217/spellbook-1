





with validation_errors as (

    select
        day, pool, token
    from `balancer_ethereum`.`balances`
    group by day, pool, token
    having count(*) > 1

)

select *
from validation_errors


