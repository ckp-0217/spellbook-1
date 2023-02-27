

SELECT *
FROM
(
        SELECT
                pool_id,
                token_address,
                normalized_weight
        FROM `balancer_v1_ethereum`.`pools_tokens_weights`
        UNION
        SELECT
                pool_id,
                token_address,
                normalized_weight
        FROM `balancer_v2_ethereum`.`pools_tokens_weights`
)