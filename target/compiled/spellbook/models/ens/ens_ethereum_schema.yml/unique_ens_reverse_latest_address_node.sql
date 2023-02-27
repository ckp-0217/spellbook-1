
    
    

select
    address_node as unique_field,
    count(*) as n_records

from `ens`.`reverse_latest`
where address_node is not null
group by address_node
having count(*) > 1


