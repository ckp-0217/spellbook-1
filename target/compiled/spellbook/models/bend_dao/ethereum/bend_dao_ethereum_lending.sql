

WITH 

borrow_events as (
        SELECT 
            contract_address, 
            evt_block_time, 
            evt_tx_hash,
            evt_block_number, 
            evt_index,
            nftTokenId as token_id, 
            nftAsset as nft_contract_address, 
            'Borrow' as evt_type, 
            onBehalfOf as address, 
            amount as amount_raw, 
            reserve as collateral_currency_contract
        FROM 
        `bend_ethereum`.`LendingPool_evt_Borrow`
        
), 

repay_events as (
        SELECT 
            contract_address, 
            evt_block_time, 
            evt_tx_hash,
            evt_block_number, 
            evt_index,
            nftTokenId as token_id, 
            nftAsset as nft_contract_address, 
            'Repay' as evt_type, 
            borrower as address, 
            amount as amount_raw, 
            reserve as collateral_currency_contract
        FROM 
        `bend_ethereum`.`LendingPool_evt_Repay`
        
), 

all_events as (
        SELECT * FROM borrow_events

        UNION ALL

        SELECT * FROM repay_events
)

SELECT 
    'ethereum' as blockchain, 
    'bend_dao' as project, 
    '1' as version, 
    date_trunc('day', ae.evt_block_time) as block_date, 
    ae.evt_block_time as block_time, 
    ae.evt_block_number as block_number, 
    ae.token_id, 
    nft_token.name as collection, 
    p.price * (ae.amount_raw/POWER(10, collateral_currency.decimals)) as amount_usd, 
    nft_token.standard as token_standard, 
    ae.evt_type, 
    ae.address, 
    ae.amount_raw/POWER(10, collateral_currency.decimals) as amount_original, 
    CAST(ae.amount_raw as DECIMAL(38,0)) as amount_raw, 
    collateral_currency.symbol as collateral_currency_symbol, 
    ae.collateral_currency_contract, 
    ae.nft_contract_address, 
    ae.contract_address as project_contract_address, 
    ae.evt_tx_hash as tx_hash, 
    et.from as tx_from, 
    et.to as tx_to,
    ae.evt_index
FROM 
all_events ae 
INNER JOIN 
`ethereum`.`transactions` et 
    ON et.block_time = ae.evt_block_time
    AND et.hash = ae.evt_tx_hash
    
    AND et.block_time >= '2022-03-21'
    
    
LEFT JOIN 
`tokens_ethereum`.`nft` nft_token
    ON nft_token.contract_address = ae.nft_contract_address
LEFT JOIN 
`tokens_ethereum`.`erc20` collateral_currency
    ON collateral_currency.contract_address = ae.collateral_currency_contract
LEFT JOIN 
`prices`.`usd` p 
    ON p.minute = date_trunc('minute', ae.evt_block_time)
    AND p.contract_address = ae.collateral_currency_contract
    AND p.blockchain = 'ethereum'
    
    AND p.minute >= '2022-03-21'
    
    