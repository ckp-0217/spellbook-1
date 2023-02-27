

SELECT
    `timestamp`,
    tx_hash,
    evt_index,
    event,
    keep3r,
    job,
    NULL AS keeper,
    token,
    amount,
    NULL AS period_credits
FROM
    `keep3r_network_ethereum`.`job_liquidity_log`
UNION ALL
SELECT
    `timestamp`,
    tx_hash,
    evt_index,
    event,
    keep3r,
    job,
    keeper,
    token,
    amount,
    period_credits
FROM
    `keep3r_network_ethereum`.`job_credits_log`
ORDER BY
    `timestamp`,
    evt_index