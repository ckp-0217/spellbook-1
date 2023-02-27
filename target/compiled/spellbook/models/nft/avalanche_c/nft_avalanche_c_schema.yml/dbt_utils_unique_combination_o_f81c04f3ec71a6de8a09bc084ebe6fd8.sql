





with validation_errors as (

    select
        unique_transfer_id
    from `nft_avalanche_c`.`transfers`
    group by unique_transfer_id
    having count(*) > 1

)

select *
from validation_errors


