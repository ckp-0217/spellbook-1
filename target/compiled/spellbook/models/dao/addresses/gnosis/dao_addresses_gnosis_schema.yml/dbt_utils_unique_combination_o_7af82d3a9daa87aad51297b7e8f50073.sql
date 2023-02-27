





with validation_errors as (

    select
        created_date, blockchain, dao_creator_tool, dao, dao_wallet_address
    from `dao`.`addresses_gnosis_daohaus`
    group by created_date, blockchain, dao_creator_tool, dao, dao_wallet_address
    having count(*) > 1

)

select *
from validation_errors


