





with validation_errors as (

    select
        proxy_address, aggregator_address
    from `chainlink_bnb`.`oracle_addresses`
    group by proxy_address, aggregator_address
    having count(*) > 1

)

select *
from validation_errors


