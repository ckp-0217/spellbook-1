
    
    

select
    unique_transfer_id as unique_field,
    count(*) as n_records

from `nft_arbitrum`.`transfers`
where unique_transfer_id is not null
group by unique_transfer_id
having count(*) > 1


