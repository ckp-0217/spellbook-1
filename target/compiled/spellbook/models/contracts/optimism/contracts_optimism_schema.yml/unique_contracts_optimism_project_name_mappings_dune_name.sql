
    
    

select
    dune_name as unique_field,
    count(*) as n_records

from `contracts_optimism`.`project_name_mappings`
where dune_name is not null
group by dune_name
having count(*) > 1


