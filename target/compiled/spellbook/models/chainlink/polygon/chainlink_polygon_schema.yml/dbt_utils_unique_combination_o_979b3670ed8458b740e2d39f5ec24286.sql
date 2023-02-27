





with validation_errors as (

    select
        blockchain, block_number, proxy_address, underlying_token_address
    from `chainlink_polygon`.`price_feeds`
    group by blockchain, block_number, proxy_address, underlying_token_address
    having count(*) > 1

)

select *
from validation_errors


