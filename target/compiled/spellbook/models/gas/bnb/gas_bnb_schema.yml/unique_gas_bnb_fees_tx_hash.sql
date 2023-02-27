
    
    

select
    tx_hash as unique_field,
    count(*) as n_records

from `gas_bnb`.`fees`
where tx_hash is not null
group by tx_hash
having count(*) > 1


