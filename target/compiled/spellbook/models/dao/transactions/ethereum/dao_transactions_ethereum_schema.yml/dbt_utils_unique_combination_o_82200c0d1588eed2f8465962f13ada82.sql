





with validation_errors as (

    select
        block_date, blockchain, dao_creator_tool, dao, dao_wallet_address, tx_hash, tx_index, tx_type, trace_address, address_interacted_with, value, asset_contract_address
    from `dao`.`transactions_ethereum_eth`
    group by block_date, blockchain, dao_creator_tool, dao, dao_wallet_address, tx_hash, tx_index, tx_type, trace_address, address_interacted_with, value, asset_contract_address
    having count(*) > 1

)

select *
from validation_errors


