

WITH namespaces AS (
    SELECT address
    , FIRST(namespace) AS namespace
	FROM `ethereum`.`contracts`
	GROUP BY address
	)

, nfts_per_tx AS (
    SELECT tx_hash
    , COUNT(*) AS nfts_minted_in_tx
    FROM `nft_ethereum`.`transfers`
    
    GROUP BY tx_hash
    )

SELECT distinct 'ethereum' AS blockchain
, COALESCE(ec.namespace, 'Unknown') AS project
, '' AS version
, nft_mints.block_time AS block_time
, date_trunc('day', nft_mints.block_time) AS block_date
, nft_mints.block_number AS block_number
, nft_mints.token_id AS token_id
, tok.name AS collection
, nft_mints.token_standard
, CASE WHEN nft_mints.amount=1 THEN 'Single Item Mint'
    ELSE 'Bundle Mint'
    END AS trade_type
, CAST(nft_mints.amount AS DECIMAL(38,0)) AS number_of_items
, 'Mint' AS trade_category
, 'Mint' AS evt_type
, nft_mints.from AS seller
, nft_mints.to AS buyer
, CAST(COALESCE(SUM(CAST(et.value as DOUBLE)), SUM(CAST(erc20s.value as DOUBLE)), 0)*(nft_mints.amount/nft_count.nfts_minted_in_tx) AS DECIMAL(38,0)) AS amount_raw
, COALESCE(SUM(CAST(et.value as DOUBLE))/POWER(10, 18), SUM(CAST(erc20s.value as DOUBLE))/POWER(10, pu_erc20s.decimals))*(nft_mints.amount/nft_count.nfts_minted_in_tx) AS amount_original
, COALESCE(pu_eth.price*SUM(CAST(et.value as DOUBLE))/POWER(10, 18), pu_erc20s.price*SUM(CAST(erc20s.value as DOUBLE))/POWER(10, pu_erc20s.decimals))*(nft_mints.amount/nft_count.nfts_minted_in_tx) AS amount_usd
, CASE WHEN et.success THEN 'ETH' ELSE pu_erc20s.symbol END AS currency_symbol
, CASE WHEN et.success THEN '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2' ELSE erc20s.contract_address END AS currency_contract
, nft_mints.contract_address AS nft_contract_address
, etxs.to AS project_contract_address
, agg.name AS aggregator_name
, agg.contract_address AS aggregator_address
, nft_mints.tx_hash AS tx_hash
, etxs.from AS tx_from
, etxs.to AS tx_to
, CAST(0 AS DOUBLE) AS platform_fee_amount_raw
, CAST(0 AS DOUBLE) AS platform_fee_amount
, CAST(0 AS DOUBLE) AS platform_fee_amount_usd
, CAST(0 AS DOUBLE) AS platform_fee_percentage
, '' AS royalty_fee_receive_address
, CAST('0' AS VARCHAR(5)) AS royalty_fee_currency_symbol
, CAST(0 AS DOUBLE) AS royalty_fee_amount_raw
, CAST(0 AS DOUBLE) AS royalty_fee_amount
, CAST(0 AS DOUBLE) AS royalty_fee_amount_usd
, CAST(0 AS DOUBLE) AS royalty_fee_percentage
, 'ethereum' || '-' || COALESCE(ec.namespace, 'Unknown') || '-Mint-' || COALESCE(nft_mints.tx_hash, '-1') || '-' || COALESCE(nft_mints.to, '-1') || '-' ||  COALESCE(nft_mints.contract_address, '-1') || '-' || COALESCE(nft_mints.token_id, '-1') || '-' || COALESCE(nft_mints.amount, '-1') || '-'|| COALESCE(erc20s.contract_address, '0x0000000000000000000000000000000000000000') || '-' || COALESCE(nft_mints.evt_index, '-1') AS unique_trade_id
FROM `nft_ethereum`.`transfers` nft_mints
LEFT JOIN nfts_per_tx nft_count ON nft_count.tx_hash=nft_mints.tx_hash
LEFT JOIN `ethereum`.`traces` et ON et.block_time=nft_mints.block_time
    AND et.tx_hash=nft_mints.tx_hash
    AND et.from=nft_mints.to
    AND (et.call_type NOT IN ('delegatecall', 'callcode', 'staticcall') OR et.call_type IS NULL)
    AND et.success
    AND CAST(et.value as DOUBLE) > 0
    
LEFT JOIN `prices`.`usd` pu_eth ON pu_eth.blockchain='ethereum'
    AND pu_eth.minute=date_trunc('minute', et.block_time)
    AND pu_eth.contract_address='0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2'
    
LEFT JOIN `erc20_ethereum`.`evt_transfer` erc20s ON erc20s.evt_block_time=nft_mints.block_time
    AND erc20s.from=nft_mints.to
    
LEFT JOIN `prices`.`usd` pu_erc20s ON pu_erc20s.blockchain='ethereum'
    AND pu_erc20s.minute=date_trunc('minute', erc20s.evt_block_time)
    AND erc20s.contract_address=pu_erc20s.contract_address
    
LEFT JOIN `ethereum`.`transactions` etxs ON etxs.block_time=nft_mints.block_time
    AND etxs.hash=nft_mints.tx_hash
    
LEFT JOIN `nft_ethereum`.`aggregators` agg ON etxs.to=agg.contract_address
LEFT JOIN `tokens_ethereum`.`nft` tok ON tok.contract_address=nft_mints.contract_address
LEFT JOIN namespaces ec ON etxs.to=ec.address

WHERE nft_mints.from='0x0000000000000000000000000000000000000000'
AND nft_mints.contract_address NOT IN (SELECT address FROM `addresses_ethereum`.`defi`)

GROUP BY nft_mints.block_time, nft_mints.block_number, nft_mints.token_id, nft_mints.token_standard
, nft_mints.amount, nft_mints.from, nft_mints.to, nft_mints.contract_address, etxs.to, nft_mints.evt_index
, nft_mints.tx_hash, etxs.from, ec.namespace, tok.name, pu_erc20s.decimals, pu_eth.price, pu_erc20s.price
, agg.name, agg.contract_address, nft_count.nfts_minted_in_tx, pu_erc20s.symbol, erc20s.contract_address, et.success