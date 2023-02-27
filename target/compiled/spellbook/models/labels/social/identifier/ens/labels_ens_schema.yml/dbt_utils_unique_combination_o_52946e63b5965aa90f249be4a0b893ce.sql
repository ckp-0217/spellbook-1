





with validation_errors as (

    select
        blockchain, address
    from `labels`.`ens`
    group by blockchain, address
    having count(*) > 1

)

select *
from validation_errors


