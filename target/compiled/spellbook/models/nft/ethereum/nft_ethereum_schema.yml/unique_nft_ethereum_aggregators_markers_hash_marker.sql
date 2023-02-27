
    
    

select
    hash_marker as unique_field,
    count(*) as n_records

from `nft_ethereum`.`aggregators_markers`
where hash_marker is not null
group by hash_marker
having count(*) > 1


