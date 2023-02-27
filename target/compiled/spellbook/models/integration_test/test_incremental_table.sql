

select
    'ethereum' as blockchain,
    date_trunc('day', evt_block_time) as day,
    wallet_address,
    token_address,
    tokenId,
    sum(amount) as amount,
    unique_tx_id || '-' || wallet_address || '-' || token_address || tokenId || '-' || sum(amount)::string as unique_transfer_id
FROM `integration_test`.`test_view`

group by
    date_trunc('day', evt_block_time), wallet_address, token_address, tokenId, unique_tx_id