





with validation_errors as (

    select
        version, tokenid, token, pool
    from `curvefi_optimism`.`pools`
    group by version, tokenid, token, pool
    having count(*) > 1

)

select *
from validation_errors


