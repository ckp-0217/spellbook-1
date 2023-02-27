


WITH trades as
(
    --sells
    SELECT
        src.seller as wallet, 
        src.nft_contract_address, 
        'Sells' as trade_type,
        SUM(src.amount_original) as eth_amount, 
        COUNT(*) as trades, 
        MAX(src.block_time) as last_updated
    FROM 
        `nft`.`trades` src 
    WHERE
        src.currency_symbol IN ('ETH', 'WETH')
        AND src.blockchain = 'ethereum'
        AND src.buyer != src.seller 
        AND src.number_of_items = 1
        AND src.amount_original IS NOT NULL 
    GROUP BY
        1, 2, 3

    UNION ALL 

    --buys
    SELECT 
        src.buyer as wallet, 
        src.nft_contract_address, 
        'Buys' as trade_type,
        -1 * SUM(src.amount_original) as eth_amount,
        COUNT(*) as trades, 
        MAX(src.block_time) as last_updated
    FROM 
        `nft`.`trades` src
    WHERE
        src.currency_symbol IN ('ETH', 'WETH')
        AND src.blockchain = 'ethereum'
        AND src.buyer != src.seller 
        AND src.number_of_items = 1
        AND src.amount_original IS NOT NULL 
    GROUP BY
        1, 2, 3
)
SELECT
    wallet, 
    nft_contract_address, 
    MAX(last_updated) as last_updated,
    COALESCE
    (
        SUM
        (
            CASE 
                WHEN trade_type = 'Buys'
                THEN ABS(eth_amount) 
                ELSE 0 
            END
        )
    , 0
    ) as eth_spent, 
    COALESCE
    (
        SUM
        (
            CASE 
                WHEN trade_type = 'Sells'
                THEN eth_amount
                ELSE 0 
            END
        )
    , 0
    ) as eth_received, 
    SUM(eth_amount) as pnl, 
    SUM(trades) as trades 
FROM 
    trades 
GROUP BY
    1, 2
