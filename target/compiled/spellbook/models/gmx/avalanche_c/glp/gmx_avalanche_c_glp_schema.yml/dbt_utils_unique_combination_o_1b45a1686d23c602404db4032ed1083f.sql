





with validation_errors as (

    select
        block_date, minute
    from `gmx_avalanche_c`.`glp_aum`
    group by block_date, minute
    having count(*) > 1

)

select *
from validation_errors


