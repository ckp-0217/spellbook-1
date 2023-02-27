
    
    

select
    address as unique_field,
    count(*) as n_records

from `labels`.`airdrop_1_receivers_optimism`
where address is not null
group by address
having count(*) > 1


