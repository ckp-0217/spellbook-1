
    
    

select
    address as unique_field,
    count(*) as n_records

from `addresses_optimism`.`cex`
where address is not null
group by address
having count(*) > 1


