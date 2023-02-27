
    
    

select
    address as unique_field,
    count(*) as n_records

from `labels`.`dao_framework`
where address is not null
group by address
having count(*) > 1


