
    
    

select
    minute as unique_field,
    count(*) as n_records

from `gmx_arbitrum`.`vault_balances`
where minute is not null
group by minute
having count(*) > 1


