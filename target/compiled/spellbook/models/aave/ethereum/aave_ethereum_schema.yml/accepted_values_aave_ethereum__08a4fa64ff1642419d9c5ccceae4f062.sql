
    
    

with all_values as (

    select
        status as value_field,
        count(*) as n_records

    from `aave_ethereum`.`proposals`
    group by status

)

select *
from all_values
where value_field not in (
    'Pending','Queued','Active','Executed','Canceled','Defeated'
)


