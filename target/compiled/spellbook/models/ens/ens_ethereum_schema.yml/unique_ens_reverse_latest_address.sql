
    
    

select
    address as unique_field,
    count(*) as n_records

from `ens`.`reverse_latest`
where address is not null
group by address
having count(*) > 1


