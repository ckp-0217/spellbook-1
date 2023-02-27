
    
    

select
    art_collection_unique_id as unique_field,
    count(*) as n_records

from `nft_ethereum_metadata`.`mirage_gallery_curated`
where art_collection_unique_id is not null
group by art_collection_unique_id
having count(*) > 1


