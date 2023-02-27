
    
    

select
    day as unique_field,
    count(*) as n_records

from `cryptopunks_ethereum`.`owners_over_time`
where day is not null
group by day
having count(*) > 1


