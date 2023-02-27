





with validation_errors as (

    select
        block_date, minute
    from `gmx_arbitrum`.`glp_components`
    group by block_date, minute
    having count(*) > 1

)

select *
from validation_errors


