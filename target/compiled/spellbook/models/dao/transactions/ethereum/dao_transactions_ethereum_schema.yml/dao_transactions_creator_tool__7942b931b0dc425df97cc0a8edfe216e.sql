

    with unit_test as
    (
        select
            case
                when lower(m.dao_creator_tool) = lower(seed.dao_creator_tool)
                    then True
                else False
            end as creator_tool_test 
        from `dao`.`transactions_ethereum_erc20` m
        inner join `test_data`.`dao_transactions_seed` seed
            on m.tx_hash = seed.tx_hash
            and m.block_date = seed.block_date
            and m.dao = seed.dao 
            and m.dao_wallet_address = seed.dao_wallet_address
            and m.tx_type = seed.tx_type
            and m.blockchain = seed.blockchain
            and m.value = seed.value 
    )
    select *
    from unit_test
    where creator_tool_test = False

