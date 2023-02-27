





with validation_errors as (

    select
        pool_id, token_address
    from `balancer_v1_ethereum`.`pools_tokens_weights`
    group by pool_id, token_address
    having count(*) > 1

)

select *
from validation_errors


