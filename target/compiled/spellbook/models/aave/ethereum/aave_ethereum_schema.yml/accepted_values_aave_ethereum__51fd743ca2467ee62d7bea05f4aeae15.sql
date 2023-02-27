
    
    

with all_values as (

    select
        support as value_field,
        count(*) as n_records

    from `aave_ethereum`.`votes`
    group by support

)

select *
from all_values
where value_field not in (
    'for','against','abstain'
)


