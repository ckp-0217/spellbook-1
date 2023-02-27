
    
    

select
    contract_address as unique_field,
    count(*) as n_records

from `contracts_optimism`.`contract_mapping`
where contract_address is not null
group by contract_address
having count(*) > 1


