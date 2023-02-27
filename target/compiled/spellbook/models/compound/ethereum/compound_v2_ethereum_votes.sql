







WITH cte_sum_votes as 
(SELECT sum(votes/1e18) as sum_votes, 
        proposalId
FROM `compound_v2_ethereum`.`GovernorBravoDelegate_evt_VoteCast`
GROUP BY proposalId)

SELECT 
    'ethereum' as blockchain,
    'compound' as project,
    'v2' as version,
    vc.evt_block_time as block_time,
    date_trunc('DAY', vc.evt_block_time) AS block_date,
    vc.evt_tx_hash as tx_hash,
    'DAO: Compound' as dao_name,
    '0xc0da02939e1441f497fd74f78ce7decb17b66529' as dao_address,
    vc.proposalId as proposal_id,
    vc.votes/1e18 as votes,
    (votes/1e18) * (100) / (csv.sum_votes) as votes_share,
    p.symbol as token_symbol,
    p.contract_address as token_address, 
    vc.votes/1e18 * p.price as votes_value_usd,
    vc.voter as voter_address,
    CASE WHEN vc.support = 0 THEN 'against'
         WHEN vc.support = 1 THEN 'for'
         WHEN vc.support = 2 THEN 'abstain'
         END AS support,
    vc.reason
FROM `compound_v2_ethereum`.`GovernorBravoDelegate_evt_VoteCast` vc
LEFT JOIN cte_sum_votes csv ON vc.proposalId = csv.proposalId
LEFT JOIN `prices`.`usd` p ON p.minute = date_trunc('minute', evt_block_time)
    AND p.symbol = 'COMP'
    AND p.blockchain ='ethereum'
    
