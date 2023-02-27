

with mints as (
    select
        '2' as version,
        'deposit' as transaction_type,
        asset_symbol as symbol,
        asset_address as token_address,
        minter as depositor,
        cast(null as varchar(5)) as withdrawn_to,
        cast(null as varchar(5)) as liquidator,
        cast(mintAmount as decimal(38, 0)) / decimals_mantissa as amount,
        cast(mintAmount as decimal(38, 0)) / decimals_mantissa * price as usd_amount,
        evt_tx_hash,
        evt_index,
        evt_block_time,
        evt_block_number,
        date_trunc('DAY', evt_block_time) as block_date
    from (
        select * from `compound_v2_ethereum`.`cErc20_evt_Mint`
        
        union all
        select * from `compound_v2_ethereum`.`cEther_evt_Mint`
        
    ) evt_mint
    left join `compound_v2_ethereum`.`ctokens` ctokens
        on evt_mint.contract_address = ctokens.ctoken_address
    left join `prices`.`usd` p
        on p.minute = date_trunc('minute', evt_mint.evt_block_time)
        and p.contract_address = ctokens.asset_address
        and p.blockchain = 'ethereum'
        
),
redeems as (
    select
        '2' as version,
        'withdraw' as transaction_type,
        asset_symbol as symbol,
        asset_address as token_address,
        redeemer as depositor,
        redeemer as withdrawn_to,
        cast(null as varchar(5)) as liquidator,
        -cast(redeemAmount as decimal(38, 0)) / decimals_mantissa as amount,
        -cast(redeemAmount as decimal(38, 0)) / decimals_mantissa * price as usd_amount,
        evt_tx_hash,
        evt_index,
        evt_block_time,
        evt_block_number,
        date_trunc('DAY', evt_block_time) as block_date
    from (
        select * from `compound_v2_ethereum`.`cErc20_evt_Redeem`
        
        union all
        select * from `compound_v2_ethereum`.`cEther_evt_Redeem`
        
    ) evt_mint
    left join `compound_v2_ethereum`.`ctokens` ctokens
        on evt_mint.contract_address = ctokens.ctoken_address
    left join `prices`.`usd` p
        on p.minute = date_trunc('minute', evt_mint.evt_block_time)
        and p.contract_address = ctokens.asset_address
        and p.blockchain = 'ethereum'
        
)


select * from mints
union all
select * from redeems