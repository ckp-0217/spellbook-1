
SELECT distinct
    wallet_address,
    token_address,
    tokenId,
    nft_tokens.name as collection,
    updated_at
FROM `transfers_ethereum`.`erc721_rolling_day`
LEFT JOIN `tokens`.`nft` nft_tokens ON nft_tokens.contract_address = token_address
AND nft_tokens.blockchain = 'ethereum'
WHERE recency_index = 1