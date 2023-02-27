





with validation_errors as (

    select
        address
    from `labels`.`balancer_v2_pools_polygon`
    group by address
    having count(*) > 1

)

select *
from validation_errors


