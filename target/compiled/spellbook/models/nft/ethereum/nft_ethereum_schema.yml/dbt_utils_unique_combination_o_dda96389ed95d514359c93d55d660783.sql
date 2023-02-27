





with validation_errors as (

    select
        nft_contract_address, minter
    from `nft_ethereum`.`top_minters`
    group by nft_contract_address, minter
    having count(*) > 1

)

select *
from validation_errors


