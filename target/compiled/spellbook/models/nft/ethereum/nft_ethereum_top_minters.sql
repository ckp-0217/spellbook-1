


SELECT 
    nft_contract_address,
    buyer as minter, 
    SUM(amount_original) as eth_spent, 
    COUNT(*) as no_minted,
    MAX(block_time) as last_updated
FROM 
    `nft`.`mints`
WHERE
    blockchain = 'ethereum'
    AND currency_symbol IN ('WETH', 'ETH')
    AND amount_original IS NOT NULL
GROUP BY 
    1, 2
