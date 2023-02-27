
SELECT 
  node,
  label,
  min(evt_block_time) AS min_evt_block_time, 
  max(evt_block_time) AS max_evt_block_time, 
  count(*) as count_ens_registries
  FROM (
    SELECT * 
    FROM `ethereumnameservice_ethereum`.`ENSRegistry_evt_NewOwner`
    UNION
    SELECT * FROM `ethereumnameservice_ethereum`.`ENSRegistryWithFallback_evt_NewOwner`
  ) r
GROUP BY node, label ;