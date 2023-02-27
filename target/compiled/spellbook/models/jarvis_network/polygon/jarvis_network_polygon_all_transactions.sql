




SELECT  'polygon'                                             AS blockchain,
        evt_block_time,
        try_cast(date_trunc('DAY', evt_block_time) as date)   AS block_date,
        action,
        user,
        recipient,
        jfiat_token_symbol,
        jfiat_token_amount,
        collateral_symbol,
        collateral_token_amount,
        net_collateral_amount,
        fee_amount,
        collateral_token_amount_usd
        net_collateral_amount_usd,
        fee_amount_usd,
        evt_tx_hash,
        evt_index
FROM
(
  SELECT  evt_block_time,
          action,
          user,
          recipient,
          am.jfiat_symbol                                       AS jfiat_token_symbol,
          jfiat_token_amount/POWER(10,am.decimals)              AS jfiat_token_amount,
          jfiat_collateral_symbol as collateral_symbol,
          collateral_token_amount/POWER(10,cm.decimals)         AS collateral_token_amount,
          net_collateral_amount/POWER(10,cm.decimals)           AS net_collateral_amount,
          fee_amount/POWER(10,cm.decimals) as fee_amount,
          collateral_token_amount/POWER(10,cm.decimals) * price AS collateral_token_amount_usd,
          net_collateral_amount/POWER(10,cm.decimals) * price   AS net_collateral_amount_usd,
          fee_amount/POWER(10,cm.decimals) * price              AS fee_amount_usd,
          evt_tx_hash,
          evt_index
  FROM
  (
    SELECT  evt_block_time,
            'Mint'                                                AS action,
            contract_address,
            user,
            recipient,
            mintvalues:numTokens                                  AS jfiat_token_amount,
            mintvalues:totalCollateral                            AS collateral_token_amount,
            mintvalues:exchangeAmount                             AS net_collateral_amount,
            mintvalues:feeAmount                                  AS fee_amount,
            evt_tx_hash,
            evt_index
    FROM `jarvis_network_polygon`.`SynthereumMultiLpLiquidityPool_evt_Minted`
    
    
    WHERE evt_block_time >= '2021-08-16'
    

    UNION ALL

    SELECT  evt_block_time,
            'Redeem'                                              AS action,
            contract_address,
            user                                                  AS sender,
            recipient,
            redeemvalues:numTokens                                AS jfiat_token_amount,
            redeemvalues:collateralAmount                         AS collateral_token_amount,
            redeemvalues:exchangeAmount                           AS net_collateral_amount,
            redeemvalues:feeAmount                                AS fee_amount,
            evt_tx_hash,
            evt_index
    FROM `jarvis_network_polygon`.`SynthereumMultiLpLiquidityPool_evt_Redeemed`
    
    
    WHERE evt_block_time >= '2021-08-16'
    

    UNION ALL

    SELECT  evt_block_time,
            'Mint'                                                AS action,
            contract_address,
            account                                               AS user,
            recipient,
            numTokensReceived                                     AS jfiat_token_amount,
            collateralSent                                        AS collateral_token_amount,
            (collateralSent - feePaid)                            AS net_collateral_amount,
            feePaid                                               AS fee_amount,
            evt_tx_hash,
            evt_index
    FROM `jarvis_network_polygon`.`SynthereumPoolOnChainPriceFeed_evt_Mint`
    
    
    WHERE evt_block_time >= '2021-08-16'
    

    UNION ALL

    SELECT  evt_block_time,
            'Redeem'                                              AS action,
            contract_address,
            account                                               AS user,
            recipient,
            numTokensSent                                         AS jfiat_token_amount,
            collateralReceived + feePaid                          AS collateral_token_amount,
            collateralReceived                                    AS net_collateral_amount,
            feePaid                                               AS fee_amount,
            evt_tx_hash,
            evt_index
    FROM `jarvis_network_polygon`.`SynthereumPoolOnChainPriceFeed_evt_Redeem`
    
    
    WHERE evt_block_time >= '2021-08-16'
    

    UNION ALL

    SELECT  evt_block_time,
            'Exchange'                                            AS action,
            contract_address,
            account                                               AS sender,
            recipient,
            numTokensSent                                         AS jfiat_token_amount,
            (feePaid * 1000)                                      AS collateral_token_amount,
            ((feePaid * 1000) - feePaid)                          AS net_collateral_amount,
            feePaid as fee_amount,
            evt_tx_hash,
            evt_index
    FROM `jarvis_network_polygon`.`SynthereumPoolOnChainPriceFeed_evt_Exchange`
    
    
    WHERE evt_block_time >= '2021-08-16'
    
  ) x
  INNER JOIN `jarvis_network_polygon`.`jfiat_address_mapping`    am
      ON (x.contract_address = am.jfiat_collateral_pool_address)
  LEFT JOIN  `jarvis_network_polygon`.`jfiat_collateral_mapping` cm
      ON (am.jfiat_collateral_pool_address = cm.jfiat_collateral_pool_address)
  LEFT JOIN  `prices`.`usd`                                pu
      ON am.blockchain = pu.blockchain
      AND cm.jfiat_collateral_symbol = pu.symbol
      AND date_trunc('minute',x.evt_block_time) = pu.minute
      
      AND pu.minute >= '2021-08-16'
      
      
) p
;