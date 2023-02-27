

    with unit_test as
    (
        select
            case
                when lower(m.dao_creator_tool) = lower(seed.dao_creator_tool)
                    then True
                else False
            end as creator_tool_test 
        from `dao`.`addresses_gnosis_daohaus` m
        inner join `test_data`.`dao_addresses_seed` seed
            on m.created_date = seed.created_date
            and m.dao = seed.dao
            and m.dao_wallet_address = seed.dao_wallet_address
            and m.blockchain = seed.blockchain
    )
    select *
    from unit_test
    where creator_tool_test  = False

