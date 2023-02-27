

-- PoC Query here - https://dune.com/queries/1752782
select
    distinct order_uid,
    block_number,
    tx_hash,
    solver,
    data.amount as cow_reward,
    cast(data.surplus_fee as double) as surplus_fee
from `cowswap`.`raw_order_rewards`