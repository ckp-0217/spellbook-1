
    
    

select
    token_id as unique_field,
    count(*) as n_records

from `nft_ethereum_metadata`.`terraforms`
where token_id is not null
group by token_id
having count(*) > 1


