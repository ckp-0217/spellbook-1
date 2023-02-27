

     -- select min(evt_block_time) from biswap_bnb.BiswapPair_evt_Swap

WITH biswap_dex AS (
    SELECT  t.evt_block_time                                             AS block_time,
            `to`                                                         AS taker,
            sender                                                       AS maker,
            CASE WHEN amount0Out = 0 THEN amount1Out ELSE amount0Out END AS token_bought_amount_raw,
            CASE WHEN amount0In = 0 THEN amount1In ELSE amount0In END    AS token_sold_amount_raw,
            cast(NULL as double)                                         AS amount_usd,
            CASE WHEN amount0Out = 0 THEN token1 ELSE token0 END         AS token_bought_address,
            CASE WHEN amount0In = 0 THEN token1 ELSE token0 END          AS token_sold_address,
            t.contract_address                                           AS project_contract_address,
            t.evt_tx_hash                                                AS tx_hash,
            ''                                                           AS trace_address,
            t.evt_index
    FROM `biswap_bnb`.`BiswapPair_evt_Swap` t
    INNER JOIN `biswap_bnb`.`BiswapFactory_evt_PairCreated` p
        ON t.contract_address = p.pair
    
    
    WHERE t.evt_block_time >= '2021-05-22'
    
)

SELECT 'bnb'                                                           AS blockchain,
       'biswap'                                                        AS project,
       '1'                                                             AS version,
       try_cast(date_trunc('DAY', biswap_dex.block_time) AS date)      AS block_date,
       biswap_dex.block_time,
       erc20a.symbol                                                   AS token_bought_symbol,
       erc20b.symbol                                                   AS token_sold_symbol,
       CASE
           WHEN lower(erc20a.symbol) > lower(erc20b.symbol) THEN concat(erc20b.symbol, '-', erc20a.symbol)
           ELSE concat(erc20a.symbol, '-', erc20b.symbol)
           END                                                         AS token_pair,
       biswap_dex.token_bought_amount_raw / power(10, erc20a.decimals) AS token_bought_amount,
       biswap_dex.token_sold_amount_raw / power(10, erc20b.decimals)   AS token_sold_amount,
       CAST(biswap_dex.token_bought_amount_raw AS DECIMAL(38,0)) AS token_bought_amount_raw,
       CAST(biswap_dex.token_sold_amount_raw AS DECIMAL(38,0)) AS token_sold_amount_raw,
       coalesce(
               biswap_dex.amount_usd
           , (biswap_dex.token_bought_amount_raw / power(10, p_bought.decimals)) * p_bought.price
           , (biswap_dex.token_sold_amount_raw / power(10, p_sold.decimals)) * p_sold.price
           )                                                           AS amount_usd,
       biswap_dex.token_bought_address,
       biswap_dex.token_sold_address,
       coalesce(biswap_dex.taker, tx.from)                             AS taker,
       biswap_dex.maker,
       biswap_dex.project_contract_address,
       biswap_dex.tx_hash,
       tx.from                                                         AS tx_from,
       tx.to                                                           AS tx_to,
       biswap_dex.trace_address,
       biswap_dex.evt_index
FROM biswap_dex
INNER JOIN `bnb`.`transactions` tx
    ON biswap_dex.tx_hash = tx.hash
    
    
    AND tx.block_time >= '2021-05-22'
    
LEFT JOIN `tokens`.`erc20` erc20a
    ON erc20a.contract_address = biswap_dex.token_bought_address
    AND erc20a.blockchain = 'bnb'
LEFT JOIN `tokens`.`erc20` erc20b
    ON erc20b.contract_address = biswap_dex.token_sold_address
    AND erc20b.blockchain = 'bnb'
LEFT JOIN `prices`.`usd` p_bought
    ON p_bought.minute = date_trunc('minute', biswap_dex.block_time)
    AND p_bought.contract_address = biswap_dex.token_bought_address
    AND p_bought.blockchain = 'bnb'
    
    
    AND p_bought.minute >= '2021-05-22'
    
LEFT JOIN `prices`.`usd` p_sold
    ON p_sold.minute = date_trunc('minute', biswap_dex.block_time)
    AND p_sold.contract_address = biswap_dex.token_sold_address
    AND p_sold.blockchain = 'bnb'
    
    
    AND p_sold.minute >= '2021-05-22'
    
;