
    
    

with all_values as (

    select
        status as value_field,
        count(*) as n_records

    from `compound_v2_ethereum`.`proposals`
    group by status

)

select *
from all_values
where value_field not in (
    'Queued','Active','Executed','Canceled','Defeated'
)


