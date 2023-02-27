





with validation_errors as (

    select
        pool_id, token_address
    from `balancer_v2_polygon`.`pools_tokens_weights`
    group by pool_id, token_address
    having count(*) > 1

)

select *
from validation_errors


