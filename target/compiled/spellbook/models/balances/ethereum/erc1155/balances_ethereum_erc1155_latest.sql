
SELECT
    wallet_address,
    token_address,
    tokenId,
    amount,
    nft_tokens.name as collection,
    nft_tokens.category as category,
    updated_at
FROM `transfers_ethereum`.`erc1155_rolling_hour`
LEFT JOIN `tokens`.`nft` nft_tokens ON nft_tokens.contract_address = token_address
AND nft_tokens.blockchain = 'ethereum'