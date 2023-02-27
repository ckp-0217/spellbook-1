



SELECT *
FROM (
    
    SELECT
        blockchain,
        block_number,
        block_time,
        block_date,
        tx_hash,
        tx_sender, 
        tx_receiver,
        native_token_symbol,
        tx_amount_native,
        tx_amount_usd,
        tx_fee_native,
        tx_fee_usd,
        burned_native,
        burned_usd,
        validator,
        gas_price_gwei,
        gas_price_usd,
        gas_used,
        gas_limit,
        gas_usage_percent,
        transaction_type
    FROM `gas_ethereum`.`fees`
    
    UNION ALL
    
    
    SELECT
        blockchain,
        block_number,
        block_time,
        block_date,
        tx_hash,
        tx_sender, 
        tx_receiver,
        native_token_symbol,
        tx_amount_native,
        tx_amount_usd,
        tx_fee_native,
        tx_fee_usd,
        burned_native,
        burned_usd,
        validator,
        gas_price_gwei,
        gas_price_usd,
        gas_used,
        gas_limit,
        gas_usage_percent,
        transaction_type
    FROM `gas_bnb`.`fees`
    
    UNION ALL
    
    
    SELECT
        blockchain,
        block_number,
        block_time,
        block_date,
        tx_hash,
        tx_sender, 
        tx_receiver,
        native_token_symbol,
        tx_amount_native,
        tx_amount_usd,
        tx_fee_native,
        tx_fee_usd,
        burned_native,
        burned_usd,
        validator,
        gas_price_gwei,
        gas_price_usd,
        gas_used,
        gas_limit,
        gas_usage_percent,
        transaction_type
    FROM `gas_avalanche_c`.`fees`
    
    UNION ALL
    
    
    SELECT
        blockchain,
        block_number,
        block_time,
        block_date,
        tx_hash,
        tx_sender, 
        tx_receiver,
        native_token_symbol,
        tx_amount_native,
        tx_amount_usd,
        tx_fee_native,
        tx_fee_usd,
        burned_native,
        burned_usd,
        validator,
        gas_price_gwei,
        gas_price_usd,
        gas_used,
        gas_limit,
        gas_usage_percent,
        transaction_type
    FROM `gas_optimism`.`fees`
    
    UNION ALL
    
    
    SELECT
        blockchain,
        block_number,
        block_time,
        block_date,
        tx_hash,
        tx_sender, 
        tx_receiver,
        native_token_symbol,
        tx_amount_native,
        tx_amount_usd,
        tx_fee_native,
        tx_fee_usd,
        burned_native,
        burned_usd,
        validator,
        gas_price_gwei,
        gas_price_usd,
        gas_used,
        gas_limit,
        gas_usage_percent,
        transaction_type
    FROM `gas_arbitrum`.`fees`
    
    
)