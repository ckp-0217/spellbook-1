
    
    

select
    hash as unique_field,
    count(*) as n_records

from `bnb`.`transactions`
where hash is not null
group by hash
having count(*) > 1


