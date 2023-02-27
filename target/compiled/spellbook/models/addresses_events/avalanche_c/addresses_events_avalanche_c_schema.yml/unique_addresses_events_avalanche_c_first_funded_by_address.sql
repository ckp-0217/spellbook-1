
    
    

select
    address as unique_field,
    count(*) as n_records

from `addresses_events_avalanche_c`.`first_funded_by`
where address is not null
group by address
having count(*) > 1


