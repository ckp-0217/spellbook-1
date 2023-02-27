

SELECT 'avalanche_c' as blockchain, * FROM  `nft_avalanche_c`.`aggregators`
UNION ALL
SELECT 'bnb' as blockchain, * FROM  `nft_bnb`.`aggregators`
UNION ALL
SELECT 'ethereum' as blockchain, * FROM  `nft_ethereum`.`aggregators`
UNION ALL
SELECT 'polygon' as blockchain, * FROM  `nft_polygon`.`aggregators`
UNION ALL
SELECT 'optimism' as blockchain, * FROM  `nft_optimism`.`aggregators`