
    
    

select
    hash as unique_field,
    count(*) as n_records

from `goerli`.`transactions`
where hash is not null
group by hash
having count(*) > 1


