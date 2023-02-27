

--
-- Balancer v2 Pools Tokens Weights
--
SELECT
    registered.poolId AS pool_id,
    tokens.token_address,
    weights.normalized_weight / POWER(10, 18) AS normalized_weight
FROM `balancer_v2_ethereum`.`Vault_evt_PoolRegistered` registered
INNER JOIN `balancer_v2_ethereum`.`WeightedPoolFactory_call_create` call_create
    ON call_create.output_0 = SUBSTRING(registered.poolId, 0, 42)
    LATERAL VIEW posexplode(call_create.tokens) tokens AS pos, token_address
    LATERAL VIEW posexplode(call_create.weights) weights AS pos, normalized_weight
WHERE tokens.pos = weights.pos
    
UNION ALL

SELECT
    registered.poolId AS pool_id,
    tokens.token_address,
    weights.normalized_weight / POWER(10, 18) AS normalized_weight
FROM `balancer_v2_ethereum`.`Vault_evt_PoolRegistered` registered
INNER JOIN `balancer_v2_ethereum`.`WeightedPool2TokensFactory_call_create` call_create
    ON call_create.output_0 = SUBSTRING(registered.poolId, 0, 42)
    LATERAL VIEW posexplode(call_create.tokens) tokens AS pos, token_address
    LATERAL VIEW posexplode(call_create.weights) weights AS pos, normalized_weight
WHERE tokens.pos = weights.pos
    
UNION ALL

SELECT
    registered.poolId AS pool_id,
    tokens.token_address,
    weights.normalized_weight / POWER(10, 18) AS normalized_weight
FROM `balancer_v2_ethereum`.`Vault_evt_PoolRegistered` registered
INNER JOIN `balancer_v2_ethereum`.`WeightedPoolV2Factory_call_create` call_create
    ON call_create.output_0 = SUBSTRING(registered.poolId, 0, 42)
    LATERAL VIEW posexplode(call_create.tokens) tokens AS pos, token_address
    LATERAL VIEW posexplode(call_create.normalizedWeights) weights AS pos, normalized_weight
WHERE tokens.pos = weights.pos
    
;