




SELECT *
FROM (
    
    SELECT
        blockchain,
        project,
        version,
        block_time,
        tx_hash,
        dao_name,
        dao_address,
        proposal_id,
        votes,
        votes_share,
        token_symbol,
        token_address,
        votes_value_usd,
        voter_address,
        support,
        reason
    FROM `uniswap_v3_ethereum`.`votes`
    
    UNION ALL
    
    
    SELECT
        blockchain,
        project,
        version,
        block_time,
        tx_hash,
        dao_name,
        dao_address,
        proposal_id,
        votes,
        votes_share,
        token_symbol,
        token_address,
        votes_value_usd,
        voter_address,
        support,
        reason
    FROM `compound_v2_ethereum`.`votes`
    
    UNION ALL
    
    
    SELECT
        blockchain,
        project,
        version,
        block_time,
        tx_hash,
        dao_name,
        dao_address,
        proposal_id,
        votes,
        votes_share,
        token_symbol,
        token_address,
        votes_value_usd,
        voter_address,
        support,
        reason
    FROM `gitcoin_ethereum`.`votes`
    
    UNION ALL
    
    
    SELECT
        blockchain,
        project,
        version,
        block_time,
        tx_hash,
        dao_name,
        dao_address,
        proposal_id,
        votes,
        votes_share,
        token_symbol,
        token_address,
        votes_value_usd,
        voter_address,
        support,
        reason
    FROM `ens_ethereum`.`votes`
    
    UNION ALL
    
    
    SELECT
        blockchain,
        project,
        version,
        block_time,
        tx_hash,
        dao_name,
        dao_address,
        proposal_id,
        votes,
        votes_share,
        token_symbol,
        token_address,
        votes_value_usd,
        voter_address,
        support,
        reason
    FROM `aave_ethereum`.`votes`
    
    
)