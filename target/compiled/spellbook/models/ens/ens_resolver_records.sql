

with resolver_records as (
    select
    a as address
    ,node
    ,evt_block_time as block_time
    ,evt_tx_hash as tx_hash
    ,evt_index
    from `ethereumnameservice_ethereum`.`PublicResolver_evt_AddrChanged`
    
   )

select
    n.name
    ,r.address
    ,r.node
    ,r.block_time
    ,r.tx_hash
    ,r.evt_index
from resolver_records r
inner join `ens`.`node_names` n
ON r.node = n.node