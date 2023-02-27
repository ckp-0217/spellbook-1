
    
    

select
    unique_trade_id as unique_field,
    count(*) as n_records

from `nft_ethereum`.`native_mints`
where unique_trade_id is not null
group by unique_trade_id
having count(*) > 1


