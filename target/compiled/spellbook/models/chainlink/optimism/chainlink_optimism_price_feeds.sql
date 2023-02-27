
-- OVM1 Launch




SELECT
    'optimism' as blockchain
    , c.block_time
    , c.block_date
    , c.block_number
    , c.feed_name
    , c.oracle_price
    , c.proxy_address
    , c.aggregator_address
    , COALESCE(o.underlying_token_address, 'n/a') AS underlying_token_address
    , c.oracle_price / POWER(10 , o.extra_decimals) AS underlying_token_price
FROM
(
    SELECT
        l.block_time
        , DATE_TRUNC('day', l.block_time) AS block_date
        , l.block_number
	    , cfa.feed_name
	    , AVG(
            conv( --handle for multiple updates in the same block
            substring(l.topic2,3,64) 
            ,16,10)
            / POWER(10, cfa.decimals)
            ) AS oracle_price
	    , cfa.proxy_address
        , cfa.aggregator_address
	FROM `optimism`.`logs` l
	INNER JOIN `chainlink_optimism`.`oracle_addresses` cfa
	    ON l.contract_address = cfa.aggregator_address
	WHERE l.topic1 = '0x0559884fd3a460db3073b7fc896cc77986f16e378210ded43186175bf646fc5f'
        
        AND l.block_time >= '2021-06-23'
        
        
    GROUP BY
        l.block_time
        , block_date
        , l.block_number
        , cfa.feed_name
        , cfa.proxy_address
        , cfa.aggregator_address
) c
LEFT JOIN `chainlink_optimism`.`oracle_token_mapping` o
	ON c.proxy_address = o.proxy_address
;