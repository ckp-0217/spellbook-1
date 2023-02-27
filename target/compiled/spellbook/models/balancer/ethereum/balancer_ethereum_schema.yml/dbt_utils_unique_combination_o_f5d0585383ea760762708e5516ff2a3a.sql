





with validation_errors as (

    select
        round_id, gauge, provider
    from `balancer_ethereum`.`vebal_votes`
    group by round_id, gauge, provider
    having count(*) > 1

)

select *
from validation_errors


