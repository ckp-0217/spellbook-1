
    
    

select
    punk_id as unique_field,
    count(*) as n_records

from `cryptopunks_ethereum`.`current_bids`
where punk_id is not null
group by punk_id
having count(*) > 1


