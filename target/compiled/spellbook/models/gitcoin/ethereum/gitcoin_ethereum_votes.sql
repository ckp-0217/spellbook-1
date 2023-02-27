






WITH cte_sum_votes as 
(SELECT sum(votes/1e18) as sum_votes, 
        proposalId
FROM `gitcoin_ethereum`.`GovernorAlpha_evt_VoteCast`
GROUP BY proposalId)

SELECT 
    'ethereum' as blockchain,
    'gitcoin' as project,
    cast(NULL as string) as version,
    vc.evt_block_time as block_time,
    date_trunc('DAY', vc.evt_block_time) AS block_date,
    vc.evt_tx_hash as tx_hash,
    'DAO: Gitcoin' as dao_name,
    '0xdbd27635a534a3d3169ef0498beb56fb9c937489' as dao_address,
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
    cast(NULL as string) as reason
FROM `gitcoin_ethereum`.`GovernorAlpha_evt_VoteCast` vc
LEFT JOIN cte_sum_votes csv ON vc.proposalId = csv.proposalId
LEFT JOIN `prices`.`usd` p ON p.minute = date_trunc('minute', evt_block_time)
    AND p.symbol = 'GTC'
    AND p.blockchain ='ethereum'
    
