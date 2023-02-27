






with cte_latest_block as (
SELECT MAX(b.number) AS latest_block
FROM `ethereum`.`blocks` b
),

cte_support as (SELECT 
        voter as voter,
        CASE WHEN support = 0 THEN sum(votingPower/1e18) ELSE 0 END AS votes_against,
        CASE WHEN support = 1 THEN sum(votingPower/1e18) ELSE 0 END AS votes_for,
        CASE WHEN support = 2 THEN sum(votingPower/1e18) ELSE 0 END AS votes_abstain,
        id
FROM `aave_ethereum`.`AaveGovernanceV2_evt_VoteEmitted`
GROUP BY support, id, voter),

cte_sum_votes as (
SELECT COUNT(DISTINCT voter) as number_of_voters,
       SUM(votes_for) as votes_for, 
       SUM(votes_against) as votes_against, 
       SUM(votes_abstain) as votes_abstain, 
       SUM(votes_for) + SUM(votes_against) + SUM(votes_abstain) as votes_total,
       id
from cte_support
GROUP BY id)

SELECT DISTINCT
    'ethereum' as blockchain,
    'aave' as project,
    cast(NULL as string) as version,
    pcr.evt_block_time as created_at,
    date_trunc('DAY', pcr.evt_block_time) AS block_date,
    pcr.evt_tx_hash as tx_hash, -- Proposal Created tx hash
    'DAO: AAVE' as dao_name,
    '0xec568fffba86c094cf06b22134b23074dfe2252c' as dao_address,
    creator as proposer,
    pcr.id as proposal_id,
    csv.votes_for,
    csv.votes_against,
    csv.votes_abstain,
    csv.votes_total,
    csv.number_of_voters,
    csv.votes_total / 1e9 * 100 AS participation, -- Total votes / Total supply (1B for Uniswap)
    pcr.startBlock as start_block,
    pcr.endBlock as end_block,
    CASE 
         WHEN pex.id is not null and now() > pex.evt_block_time THEN 'Executed' 
         WHEN pca.id is not null and now() > pca.evt_block_time THEN 'Canceled'
         WHEN (SELECT latest_block FROM cte_latest_block) <= pcr.startBlock THEN 'Pending'
         WHEN (SELECT latest_block FROM cte_latest_block) <= pcr.endBlock THEN 'Active'
         WHEN pqu.id is not null and now() > pqu.evt_block_time and now() < CAST(CAST(pqu.executionTime AS numeric) AS TIMESTAMP) THEN 'Queued'
         ELSE 'Defeated' END AS status,
    cast(NULL as string) as description
FROM  `aave_ethereum`.`AaveGovernanceV2_evt_ProposalCreated` pcr
LEFT JOIN cte_sum_votes csv ON csv.id = pcr.id
LEFT JOIN `aave_ethereum`.`AaveGovernanceV2_evt_ProposalCanceled` pca ON pca.id = pcr.id
LEFT JOIN `aave_ethereum`.`AaveGovernanceV2_evt_ProposalExecuted` pex ON pex.id = pcr.id
LEFT JOIN `aave_ethereum`.`AaveGovernanceV2_evt_ProposalQueued` pqu ON pqu.id = pcr.id
