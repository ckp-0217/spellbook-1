





with validation_errors as (

    select
        address, name, category, blockchain
    from `labels`.`all`
    group by address, name, category, blockchain
    having count(*) > 1

)

select *
from validation_errors


