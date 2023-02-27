

    with unit_test as
    (
        select
            seed.test_description,
            case
                when m.buyer = seed.buyer
                    then True
                else False
            end as generic_column_test
        from `cryptopunks_ethereum`.`trades` m
        join `test_data`.`cryptopunks_trades_buys_bids_seed` seed
            on m.tx_hash = seed.tx_hash
            and m.block_number = seed.block_number
    )

    select test_description
    from unit_test
    where generic_column_test = False

