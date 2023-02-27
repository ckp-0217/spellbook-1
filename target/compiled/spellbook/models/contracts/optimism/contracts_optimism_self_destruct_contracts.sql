

with creates as (
    select 
      block_time as created_time
      ,tx_hash as creation_tx_hash
      ,address as contract_address
      ,trace_address[0] as trace_element
    from `optimism`.`traces`
    where 
      type = 'create'
      and success
      and tx_success
      
)
select
  cr.created_time 
  ,cr.creation_tx_hash 
  ,cr.contract_address 
  ,cr.trace_element
from creates as cr
join `optimism`.`traces` as sd
  on cr.creation_tx_hash = sd.tx_hash
  and cr.created_time = sd.block_time
  and cr.trace_element = sd.trace_address[0]
  and sd.`type` = 'suicide'
  
group by 1, 2, 3, 4
;