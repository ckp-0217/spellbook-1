
    
    

with all_values as (

    select
        transfer_type as value_field,
        count(*) as n_records

    from `nft_arbitrum`.`transfers`
    group by transfer_type

)

select *
from all_values
where value_field not in (
    'single','batch'
)


