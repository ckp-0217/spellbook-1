





with validation_errors as (

    select
        wallet, nft_contract_address
    from `nft_ethereum`.`wallet_pnl`
    group by wallet, nft_contract_address
    having count(*) > 1

)

select *
from validation_errors


