





with validation_errors as (

    select
        blockchain, hour, proxy_address, aggregator_address, underlying_token_address
    from `chainlink`.`price_feeds_hourly`
    group by blockchain, hour, proxy_address, aggregator_address, underlying_token_address
    having count(*) > 1

)

select *
from validation_errors


