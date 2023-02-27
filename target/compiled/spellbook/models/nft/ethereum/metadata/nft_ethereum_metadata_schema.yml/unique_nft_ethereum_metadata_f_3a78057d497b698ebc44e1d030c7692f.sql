
    
    

select
    contract_address as unique_field,
    count(*) as n_records

from `nft_ethereum_metadata`.`fellowship_gallery`
where contract_address is not null
group by contract_address
having count(*) > 1


