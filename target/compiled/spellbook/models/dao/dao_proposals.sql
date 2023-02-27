



SELECT *
FROM (
    
    SELECT
        blockchain,
        project,
        version,
        created_at,
        tx_hash,
        dao_name,
        dao_address,
        proposer,
        proposal_id,
        votes_for,
        votes_against,
        votes_abstain,
        votes_total,
        number_of_voters,
        participation,
        status,
        description
    FROM `uniswap_v3_ethereum`.`proposals`
    
    UNION ALL
    
    
    SELECT
        blockchain,
        project,
        version,
        created_at,
        tx_hash,
        dao_name,
        dao_address,
        proposer,
        proposal_id,
        votes_for,
        votes_against,
        votes_abstain,
        votes_total,
        number_of_voters,
        participation,
        status,
        description
    FROM `compound_v2_ethereum`.`proposals`
    
    UNION ALL
    
    
    SELECT
        blockchain,
        project,
        version,
        created_at,
        tx_hash,
        dao_name,
        dao_address,
        proposer,
        proposal_id,
        votes_for,
        votes_against,
        votes_abstain,
        votes_total,
        number_of_voters,
        participation,
        status,
        description
    FROM `gitcoin_ethereum`.`proposals`
    
    UNION ALL
    
    
    SELECT
        blockchain,
        project,
        version,
        created_at,
        tx_hash,
        dao_name,
        dao_address,
        proposer,
        proposal_id,
        votes_for,
        votes_against,
        votes_abstain,
        votes_total,
        number_of_voters,
        participation,
        status,
        description
    FROM `ens_ethereum`.`proposals`
    
    UNION ALL
    
    
    SELECT
        blockchain,
        project,
        version,
        created_at,
        tx_hash,
        dao_name,
        dao_address,
        proposer,
        proposal_id,
        votes_for,
        votes_against,
        votes_abstain,
        votes_total,
        number_of_voters,
        participation,
        status,
        description
    FROM `aave_ethereum`.`proposals`
    
    
)