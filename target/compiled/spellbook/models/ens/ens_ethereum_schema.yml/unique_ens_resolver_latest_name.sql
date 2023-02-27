
    
    

select
    name as unique_field,
    count(*) as n_records

from `ens`.`resolver_latest`
where name is not null
group by name
having count(*) > 1


