
SELECT *
FROM
(
        SELECT
            'ethereum' AS blockchain,
            'CoW Protocol' AS project,
            '1' AS version,
            block_date,
            block_time,
            num_trades,
            dex_swaps,
            batch_value,
            solver_address,
            tx_hash,
            gas_price,
            gas_used,
            tx_cost_usd,
            fee_value,
            call_data_size,
            unwraps,
            token_approvals
        FROM `cow_protocol_ethereum`.`batches`

        UNION ALL

        SELECT
            'gnosis' AS blockchain,
            'CoW Protocol' AS project,
            '1' AS version,
            block_date,
            block_time,
            num_trades,
            dex_swaps,
            batch_value,
            solver_address,
            tx_hash,
            gas_price,
            gas_used,
            tx_cost_usd,
            fee_value,
            call_data_size,
            unwraps,
            token_approvals
        FROM `cow_protocol_gnosis`.`batches`
)