
    
    

with all_values as (

    select
        type as value_field,
        count(*) as n_records

    from `balancer_ethereum`.`veBAL_evt_Deposit`
    group by type

)

select *
from all_values
where value_field not in (
    '0','1','2','3'
)


