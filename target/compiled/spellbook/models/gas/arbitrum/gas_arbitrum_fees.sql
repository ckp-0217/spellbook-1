

SELECT 
     'arbitrum' as blockchain,
     date_trunc('day', block_time) AS block_date,
     block_number,
     block_time,
     txns.hash AS tx_hash,
     txns.from AS tx_sender, 
     txns.to AS tx_receiver,
     'ETH' as native_token_symbol,
     value/1e18 AS tx_amount_native,
     value/1e18 * p.price AS tx_amount_usd,
     (effective_gas_price * txns.gas_used)/1e18 as tx_fee_native, 
     (effective_gas_price * txns.gas_used)/1e18 * p.price AS tx_fee_usd,
     cast(NULL as double) AS burned_native, -- Not applicable for L2s
     cast(NULL as double) AS burned_usd, -- Not applicable for L2s
     cast(NULL as string) as validator, -- Not applicable for L2s
     txns.effective_gas_price/1e9 as gas_price_gwei,
     txns.effective_gas_price/1e18 * p.price as gas_price_usd,
     txns.gas_price/1e9 as gas_price_bid_gwei,
     txns.gas_price/1e18 * p.price as gas_price_bid_usd,
     txns.gas_used as gas_used,
     txns.gas_limit as gas_limit,
     txns.gas_used / txns.gas_limit * 100 as gas_usage_percent,
     gas_used_for_l1 as l1_gas_used,
     type as transaction_type
FROM `arbitrum`.`transactions` txns
JOIN `arbitrum`.`blocks` blocks ON blocks.number = txns.block_number

LEFT JOIN `prices`.`usd` p ON p.minute = date_trunc('minute', block_time)
AND p.blockchain = 'arbitrum'
AND p.symbol = 'WETH'
