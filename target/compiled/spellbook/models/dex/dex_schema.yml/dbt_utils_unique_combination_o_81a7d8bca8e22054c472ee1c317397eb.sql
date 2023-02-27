





with validation_errors as (

    select
        hour, blockchain, contract_address
    from `dex`.`prices`
    group by hour, blockchain, contract_address
    having count(*) > 1

)

select *
from validation_errors


