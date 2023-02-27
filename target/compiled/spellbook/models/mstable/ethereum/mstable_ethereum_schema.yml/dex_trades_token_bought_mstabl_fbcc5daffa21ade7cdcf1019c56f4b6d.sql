

    with unit_test as
    (
        select
            case
                when lower(m.token_bought_address) = lower(seed.token_bought_address)
                    then True
                else False
            end as token_bought_test
        from `mstable_ethereum`.`trades` m
        inner join `test_data`.`dex_trades_seed` seed
            on m.tx_hash = seed.tx_hash
            and m.evt_index = seed.evt_index
            and m.block_date = seed.block_date
            and m.blockchain = seed.blockchain
            and m.project = seed.project
            and m.version = seed.version
    )
    select *
    from unit_test
    where token_bought_test = False

