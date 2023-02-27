



with v2 as (
    select
        '2' as version,
        tokenOut as token_bought_address,
        amountOut as token_bought_amount_raw,
        tokenIn as token_sold_address,
        amountIn as token_sold_amount_raw,
        poolAddress as project_contract_address,
        s.evt_block_time,
        s.evt_tx_hash,
        s.evt_index
    from `balancer_v2_polygon`.`Vault_evt_Swap` s
    inner join `balancer_v2_polygon`.`Vault_evt_PoolRegistered` p
    on s.poolId = p.poolId
    
        where s.evt_block_time >= '2021-06-24'
    
    
),
prices as (
    select * from `prices`.`usd`
    where blockchain = 'polygon'
    
        and minute >= '2021-06-24'
    
    
)


select
    'polygon' as blockchain,
    'balancer' as project,
    version,
    evt_block_time as block_time,
    date_trunc('day', evt_block_time) as block_date,
    erc20a.symbol as token_bought_symbol,
    erc20b.symbol as token_sold_symbol,
    case
        when lower(erc20a.symbol) > lower(erc20b.symbol) then concat(erc20b.symbol, '-', erc20a.symbol)
        else concat(erc20a.symbol, '-', erc20b.symbol)
    end as token_pair,
    token_bought_amount_raw / power(10, erc20a.decimals) as token_bought_amount,
    token_sold_amount_raw / power(10, erc20b.decimals) as token_sold_amount,
    CAST(token_bought_amount_raw AS DECIMAL(38,0)) as token_bought_amount_raw,
    CAST(token_sold_amount_raw AS DECIMAL(38,0)) as token_sold_amount_raw,
    coalesce(
        (token_bought_amount_raw / power(10, p_bought.decimals)) * p_bought.price,
        (token_sold_amount_raw / power(10, p_sold.decimals)) * p_sold.price
    ) AS amount_usd,
    token_bought_address,
    token_sold_address,
    tx.from as taker,
    cast(null as varchar(5)) as maker,
    project_contract_address,
    evt_tx_hash as tx_hash,
    tx.from as tx_from,
    tx.to as tx_to,
    evt_index,
    '' as trace_address
from v2 trades
inner join `polygon`.`transactions` tx
    on trades.evt_tx_hash = tx.hash
    
    and tx.block_time >= '2021-06-24'
    
    
left join `tokens`.`erc20` erc20a
    on trades.token_bought_address = erc20a.contract_address
    and erc20a.blockchain = 'polygon'
left join `tokens`.`erc20` erc20b
    on trades.token_sold_address = erc20b.contract_address
    and erc20b.blockchain = 'polygon'
left join prices p_bought
    ON p_bought.minute = date_trunc('minute', trades.evt_block_time)
    and p_bought.contract_address = trades.token_bought_address
left join prices p_sold
    on p_sold.minute = date_trunc('minute', trades.evt_block_time)
    and p_sold.contract_address = trades.token_sold_address