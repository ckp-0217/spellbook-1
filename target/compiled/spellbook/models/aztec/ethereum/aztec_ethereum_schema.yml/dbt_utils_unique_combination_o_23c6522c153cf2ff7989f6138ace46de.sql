





with validation_errors as (

    select
        asset_id, asset_address, asset_gas_limit, date_added
    from `aztec_v2_ethereum`.`deposit_assets`
    group by asset_id, asset_address, asset_gas_limit, date_added
    having count(*) > 1

)

select *
from validation_errors


