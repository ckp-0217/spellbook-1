





with validation_errors as (

    select
        block_date, nft_contract_address
    from `nft_ethereum`.`collection_stats`
    group by block_date, nft_contract_address
    having count(*) > 1

)

select *
from validation_errors


