





with validation_errors as (

    select
        day, pool_id, token_address
    from `balancer_v2_arbitrum`.`liquidity`
    group by day, pool_id, token_address
    having count(*) > 1

)

select *
from validation_errors


