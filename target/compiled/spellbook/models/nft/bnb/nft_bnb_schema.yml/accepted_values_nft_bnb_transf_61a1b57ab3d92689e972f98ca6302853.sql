
    
    

with all_values as (

    select
        token_standard as value_field,
        count(*) as n_records

    from `nft_bnb`.`transfers`
    group by token_standard

)

select *
from all_values
where value_field not in (
    'bep721','bep1155'
)


