

SELECT *
FROM
(
        SELECT
                pool_id,
                token_address,
                normalized_weight
        FROM `balancer_v2_arbitrum`.`pools_tokens_weights`
)