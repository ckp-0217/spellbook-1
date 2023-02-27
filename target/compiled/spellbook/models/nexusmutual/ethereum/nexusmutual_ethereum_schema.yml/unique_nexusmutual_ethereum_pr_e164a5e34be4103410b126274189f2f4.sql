
    
    

select
    product_contract_address as unique_field,
    count(*) as n_records

from `nexusmutual_ethereum`.`product_information`
where product_contract_address is not null
group by product_contract_address
having count(*) > 1


