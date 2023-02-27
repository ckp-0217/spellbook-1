
    
    

select
    node as unique_field,
    count(*) as n_records

from `ens`.`resolver_latest`
where node is not null
group by node
having count(*) > 1


