





with validation_errors as (

    select
        block_date, unique_trade_id
    from `foundation_ethereum`.`events`
    group by block_date, unique_trade_id
    having count(*) > 1

)

select *
from validation_errors


