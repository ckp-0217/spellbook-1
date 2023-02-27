





with validation_errors as (

    select
        pool, token_id, token_type
    from `ellipsis_finance_bnb`.`pool_tokens`
    group by pool, token_id, token_type
    having count(*) > 1

)

select *
from validation_errors


