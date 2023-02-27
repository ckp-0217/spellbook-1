
    
    

select
    proposal_id as unique_field,
    count(*) as n_records

from `gitcoin_ethereum`.`proposals`
where proposal_id is not null
group by proposal_id
having count(*) > 1


