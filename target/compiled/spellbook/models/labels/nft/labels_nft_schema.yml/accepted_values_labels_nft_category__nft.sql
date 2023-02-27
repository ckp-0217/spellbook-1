
    
    

with all_values as (

    select
        category as value_field,
        count(*) as n_records

    from `labels`.`nft`
    group by category

)

select *
from all_values
where value_field not in (
    'nft'
)


