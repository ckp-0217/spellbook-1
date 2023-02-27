
    
    

with all_values as (

    select
        token_standard as value_field,
        count(*) as n_records

    from `nft_gnosis`.`transfers`
    group by token_standard

)

select *
from all_values
where value_field not in (
    'erc721','erc1155'
)


