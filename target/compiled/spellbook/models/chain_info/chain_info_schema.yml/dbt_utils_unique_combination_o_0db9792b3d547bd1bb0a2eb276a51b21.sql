





with validation_errors as (

    select
        chain_id, network_id
    from `chain_info`.`chain_ids`
    group by chain_id, network_id
    having count(*) > 1

)

select *
from validation_errors


