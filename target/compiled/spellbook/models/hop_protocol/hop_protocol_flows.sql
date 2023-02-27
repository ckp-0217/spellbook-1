



SELECT *
FROM
(
        
        SELECT
                h.blockchain
                , h.project
                , h.version
                , h.block_time
                , h.block_date
                , h.block_number
                , h.tx_hash
                , h.sender
                , h.receiver
                , h.token_symbol
                , h.token_amount
                , h.token_amount_usd
                , h.token_amount_raw
                , h.fee_amount
                , h.fee_amount_usd
                , h.fee_amount_raw
                , h.token_address
                , h.fee_address
                , h.source_chain_id
                , h.destination_chain_id
                , h.source_chain_name
                , h.destination_chain_name
                , CASE WHEN sb.tx_hash IS NOT NULL
                        THEN 1 ELSE 0
                 END AS is_native_bridge
                , h.tx_from
                , h.tx_to
                , h.transfer_id
                , h.evt_index
                , h.trace_address
                , h.tx_method_id
        FROM `hop_protocol_optimism`.`flows` h
        LEFT JOIN
        
                `bridge_optimism`.`standard_bridge_flows` sb
        
        -- Add if statements for other chains here
        ON sb.tx_hash = h.tx_hash
        AND sb.block_number = h.block_number
        AND sb.block_date = h.block_date

    
    
)