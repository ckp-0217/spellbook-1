

    with unit_test as
    (
        select
            case
                when m.premium_nxm = seed.premium_nxm
                    then True
                else False
            end as generic_column_test
        from `nexusmutual_ethereum`.`trades` m
        join `test_data`.`nexusmutual_ethereum_trades_seed` seed
            on m.evt_tx_hash = seed.evt_tx_hash
            and m.evt_block_number = seed.evt_block_number
            and m.nonce = seed.nonce
            and m.curr = seed.curr
    )

    select *
    from unit_test
    where generic_column_test = False

