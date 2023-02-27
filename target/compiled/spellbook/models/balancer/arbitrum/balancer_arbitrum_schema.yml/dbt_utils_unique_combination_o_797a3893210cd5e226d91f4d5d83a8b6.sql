





with validation_errors as (

    select
        hour, contract_address
    from `balancer_v2_arbitrum`.`bpt_prices`
    group by hour, contract_address
    having count(*) > 1

)

select *
from validation_errors


