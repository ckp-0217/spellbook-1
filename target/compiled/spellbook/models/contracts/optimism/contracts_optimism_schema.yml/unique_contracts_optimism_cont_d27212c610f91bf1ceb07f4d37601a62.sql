
    
    

select
    creator_address as unique_field,
    count(*) as n_records

from `contracts_optimism`.`contract_creator_address_list`
where creator_address is not null
group by creator_address
having count(*) > 1


