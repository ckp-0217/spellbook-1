



WITH quo_evt AS (
    SELECT cid,
           contract_address,
           evt_block_number,
           evt_block_time,
           evt_index,
           evt_tx_hash,
           curr,
           expiry,
           premium,
           premiumNXM,
           scAdd,
           sumAssured,
           '0xd7c49cee7e9188cca6ad8ff264c1da2e69d4cf3b' as token
    FROM
        `nexusmutual_ethereum`.`QuotationData_evt_CoverDetailsEvent`
    
    WHERE evt_block_time >= '2019-07-12'
    
    
)
SELECT quo_evt.cid,
       quo_evt.contract_address,
       quo_evt.token                                                AS token_address,
       erc20.symbol,
       quo_evt.evt_index,
       quo_evt.evt_tx_hash,
       quo_evt.curr,
       quo_evt.premium,
       quo_evt.premium * power(10, erc20.decimals)                  AS pre_amount,
       quo_evt.premiumNXM                                           AS premium_nxm,
       quo_evt.premiumNXM * power(10, erc20.decimals)               AS pre_nxm_amount,
       quo_evt.scAdd                                                AS sc_add,
       quo_evt.sumAssured                                           AS sum_assured,
       tx.block_hash,
       tx.nonce,
       tx.gas_limit,
       tx.gas_price,
       tx.gas_used,
       tx.max_fee_per_gas,
       tx.max_priority_fee_per_gas,
       tx.priority_fee_per_gas,
       tx.success,
       tx.type                                                     AS tx_type,
       tx.value                                                    AS tx_value,
       quo_evt.evt_block_number                                    AS evt_block_number,
       quo_evt.evt_block_time                                      AS evt_block_time,
       quo_evt.expiry                                              AS evt_expiry,
       to_timestamp(quo_evt.expiry)                                AS evt_expiry_date,
       TRY_CAST(date_trunc('DAY', quo_evt.evt_block_time) AS date) AS block_date
FROM quo_evt
INNER JOIN `ethereum`.`transactions` tx
    ON quo_evt.evt_tx_hash = tx.hash
    AND tx.success is TRUE
    
    AND tx.block_time >= '2019-07-12'
    
    
LEFT JOIN `tokens`.`erc20` erc20
    ON quo_evt.token = erc20.contract_address
    AND erc20.blockchain = 'ethereum'
;