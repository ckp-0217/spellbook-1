





with validation_errors as (

    select
        blockchain, atoken_address
    from `aave_v3`.`tokens`
    group by blockchain, atoken_address
    having count(*) > 1

)

select *
from validation_errors


