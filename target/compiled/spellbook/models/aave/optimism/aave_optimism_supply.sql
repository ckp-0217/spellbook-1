

SELECT *
FROM 
(
      SELECT 
            version,
            transaction_type,
            symbol,
            token_address, 
            depositor,
            withdrawn_to,
            liquidator,
            amount,
            usd_amount,
            evt_tx_hash,
            evt_index,
            evt_block_time,
            evt_block_number 
      FROM `aave_v3_optimism`.`supply`
      /*
      UNION ALL
      < add new version as needed
      */
)