





with validation_errors as (

    select
        address, proposal_name, funding_source, project_name
    from `addresses_optimism`.`grants_funding`
    group by address, proposal_name, funding_source, project_name
    having count(*) > 1

)

select *
from validation_errors


