
    
    

select
    pool_address as unique_field,
    count(*) as n_records

from `curvefi_ethereum`.`view_pools`
where pool_address is not null
group by pool_address
having count(*) > 1


