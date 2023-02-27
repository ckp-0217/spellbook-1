
    
    

select
    contract_address as unique_field,
    count(*) as n_records

from `aztec_v2_ethereum`.`bridges`
where contract_address is not null
group by contract_address
having count(*) > 1


