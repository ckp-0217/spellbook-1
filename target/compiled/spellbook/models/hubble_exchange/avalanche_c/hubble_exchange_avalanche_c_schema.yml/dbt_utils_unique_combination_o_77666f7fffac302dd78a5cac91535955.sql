





with validation_errors as (

    select
        block_date, blockchain, project, version, tx_hash, evt_index
    from `hubble_exchange_avalanche_c`.`perpetual_trades`
    group by block_date, blockchain, project, version, tx_hash, evt_index
    having count(*) > 1

)

select *
from validation_errors


