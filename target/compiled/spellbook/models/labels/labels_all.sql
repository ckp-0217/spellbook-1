

-- single category labels (no subsets), needs label_type and model_name added still.
SELECT blockchain, address, name, category, contributor, source, created_at, updated_at, model_name, label_type FROM `labels`.`aztec_v2_contracts_ethereum`
UNION ALL
SELECT * FROM `labels`.`balancer_v2_pools`
UNION ALL
SELECT * FROM `labels`.`cex`
UNION ALL
SELECT * FROM `labels`.`contracts`
UNION ALL
SELECT * FROM `labels`.`funds`
UNION ALL
SELECT * FROM `labels`.`hackers_ethereum`
UNION ALL
SELECT * FROM `labels`.`ofac_sanctioned_ethereum`
UNION ALL
SELECT * FROM `labels`.`project_wallets`
UNION ALL
SELECT * FROM `labels`.`safe_ethereum`
UNION ALL
SELECT * FROM `labels`.`tornado_cash`

-- new/standardized labels
UNION ALL
SELECT * FROM `labels`.`bridge`
UNION ALL
SELECT * FROM `labels`.`dex`
UNION ALL
SELECT * FROM `labels`.`social`
UNION ALL
SELECT * FROM `labels`.`nft`
UNION ALL
SELECT * FROM `labels`.`airdrop`
UNION ALL
SELECT * FROM `labels`.`dao`
UNION ALL
SELECT * FROM `labels`.`infrastructure`