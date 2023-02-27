




SELECT *
FROM (
    
    SELECT
        blockchain,
        project,
        version,
        block_date,
        block_time,
        block_number,
        token_id,
        collection,
        amount_usd,
        token_standard,
        evt_type,
        address,
        amount_original,
        amount_raw,
        collateral_currency_symbol,
        collateral_currency_contract,
        nft_contract_address,
        project_contract_address,
        tx_hash,
        tx_from,
        tx_to,
        evt_index
    FROM `bend_dao_ethereum`.`lending`
    
    

)