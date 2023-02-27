





with validation_errors as (

    select
        tx_from, tx_to, value, contract_address, evt_tx_hash, evt_index, broad_txn_type, spec_txn_type, to_protocol, from_protocol, bridge_address, trace_address
    from `aztec_v2_ethereum`.`rollupbridge_transfers`
    group by tx_from, tx_to, value, contract_address, evt_tx_hash, evt_index, broad_txn_type, spec_txn_type, to_protocol, from_protocol, bridge_address, trace_address
    having count(*) > 1

)

select *
from validation_errors


