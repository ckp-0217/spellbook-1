
    
    

with all_values as (

    select
        detection_source as value_field,
        count(*) as n_records

    from `avalanche_c`.`contracts`
    group by detection_source

)

select *
from all_values
where value_field not in (
    'factory','base','dynamic'
)


