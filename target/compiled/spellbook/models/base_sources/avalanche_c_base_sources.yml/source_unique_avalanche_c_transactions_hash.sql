
    
    

select
    hash as unique_field,
    count(*) as n_records

from `avalanche_c`.`transactions`
where hash is not null
group by hash
having count(*) > 1


