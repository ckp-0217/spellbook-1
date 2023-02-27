

SELECT
b.evt_block_number AS block_number,
b.evt_block_time AS block_time,
b.evt_tx_hash AS tx_hash,
b.evt_index AS `index`,
b.contract_address,
b.borrower,
i.symbol,
i.underlying_symbol,
i.underlying_token_address AS underlying_address,
CAST(b.borrowAmount AS DOUBLE) / power(10,i.underlying_decimals) AS borrow_amount,
CAST(b.borrowAmount AS DOUBLE) / power(10,i.underlying_decimals)*p.price AS borrow_usd
FROM `ironbank_optimism`.`CErc20Delegator_evt_Borrow` b
LEFT JOIN `ironbank_optimism`.`itokens` i ON b.contract_address = i.contract_address
LEFT JOIN `prices`.`usd` p ON p.minute = date_trunc('minute', b.evt_block_time) AND p.contract_address = i.underlying_token_address AND p.blockchain = 'optimism'