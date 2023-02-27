
    
    

select
    unique_signature_id as unique_field,
    count(*) as n_records

from `abi`.`signatures`
where unique_signature_id is not null
group by unique_signature_id
having count(*) > 1


