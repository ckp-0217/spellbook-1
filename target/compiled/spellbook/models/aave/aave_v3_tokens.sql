

-- chains where aave v3 contracts are decoded.


SELECT distinct a.blockchain
              , a.atoken_address
              , a.underlying_address
              , a.atoken_decimals
              , a.side
              , a.arate_type
              , a.atoken_symbol
              , a.atoken_name
              , et.decimals AS underlying_decimals
              , et.symbol   AS underlying_symbol

FROM (
    
        SELECT
            'optimism' AS blockchain
            , contract_address AS atoken_address
            , underlyingAsset AS underlying_address
            , aTokenDecimals AS atoken_decimals
            , 'Supply' AS side
            , 'Variable' AS arate_type
            , aTokenSymbol AS atoken_symbol
            , aTokenName AS atoken_name
        FROM `aave_v3_optimism`.`AToken_evt_Initialized`
        

        UNION ALL

        SELECT
            'optimism' AS blockchain
            , contract_address AS atoken_address
            , underlyingAsset AS underlying_address
            , debtTokenDecimals AS atoken_decimals
            , 'Borrow' AS side
            , 'Stable' AS arate_type
            , debtTokenSymbol AS atoken_symbol
            , debtTokenName AS atoken_name
        FROM `aave_v3_optimism`.`StableDebtToken_evt_Initialized`
        WHERE debtTokenName LIKE '%Stable%'
        

        UNION ALL

        SELECT
            'optimism' AS blockchain
            , contract_address AS atoken_address
            , underlyingAsset AS underlying_address
            , debtTokenDecimals AS atoken_decimals
            , 'Borrow' AS side
            , 'Variable' AS arate_type
            , debtTokenSymbol AS atoken_symbol
            , debtTokenName AS atoken_name
        FROM `aave_v3_optimism`.`VariableDebtToken_evt_Initialized`
        WHERE debtTokenName LIKE '%Variable%'
        

        
        UNION ALL
        
    
        SELECT
            'polygon' AS blockchain
            , contract_address AS atoken_address
            , underlyingAsset AS underlying_address
            , aTokenDecimals AS atoken_decimals
            , 'Supply' AS side
            , 'Variable' AS arate_type
            , aTokenSymbol AS atoken_symbol
            , aTokenName AS atoken_name
        FROM `aave_v3_polygon`.`AToken_evt_Initialized`
        

        UNION ALL

        SELECT
            'polygon' AS blockchain
            , contract_address AS atoken_address
            , underlyingAsset AS underlying_address
            , debtTokenDecimals AS atoken_decimals
            , 'Borrow' AS side
            , 'Stable' AS arate_type
            , debtTokenSymbol AS atoken_symbol
            , debtTokenName AS atoken_name
        FROM `aave_v3_polygon`.`StableDebtToken_evt_Initialized`
        WHERE debtTokenName LIKE '%Stable%'
        

        UNION ALL

        SELECT
            'polygon' AS blockchain
            , contract_address AS atoken_address
            , underlyingAsset AS underlying_address
            , debtTokenDecimals AS atoken_decimals
            , 'Borrow' AS side
            , 'Variable' AS arate_type
            , debtTokenSymbol AS atoken_symbol
            , debtTokenName AS atoken_name
        FROM `aave_v3_polygon`.`VariableDebtToken_evt_Initialized`
        WHERE debtTokenName LIKE '%Variable%'
        

        
        UNION ALL
        
    
        SELECT
            'arbitrum' AS blockchain
            , contract_address AS atoken_address
            , underlyingAsset AS underlying_address
            , aTokenDecimals AS atoken_decimals
            , 'Supply' AS side
            , 'Variable' AS arate_type
            , aTokenSymbol AS atoken_symbol
            , aTokenName AS atoken_name
        FROM `aave_v3_arbitrum`.`AToken_evt_Initialized`
        

        UNION ALL

        SELECT
            'arbitrum' AS blockchain
            , contract_address AS atoken_address
            , underlyingAsset AS underlying_address
            , debtTokenDecimals AS atoken_decimals
            , 'Borrow' AS side
            , 'Stable' AS arate_type
            , debtTokenSymbol AS atoken_symbol
            , debtTokenName AS atoken_name
        FROM `aave_v3_arbitrum`.`StableDebtToken_evt_Initialized`
        WHERE debtTokenName LIKE '%Stable%'
        

        UNION ALL

        SELECT
            'arbitrum' AS blockchain
            , contract_address AS atoken_address
            , underlyingAsset AS underlying_address
            , debtTokenDecimals AS atoken_decimals
            , 'Borrow' AS side
            , 'Variable' AS arate_type
            , debtTokenSymbol AS atoken_symbol
            , debtTokenName AS atoken_name
        FROM `aave_v3_arbitrum`.`VariableDebtToken_evt_Initialized`
        WHERE debtTokenName LIKE '%Variable%'
        

        
        UNION ALL
        
    
        SELECT
            'avalanche_c' AS blockchain
            , contract_address AS atoken_address
            , underlyingAsset AS underlying_address
            , aTokenDecimals AS atoken_decimals
            , 'Supply' AS side
            , 'Variable' AS arate_type
            , aTokenSymbol AS atoken_symbol
            , aTokenName AS atoken_name
        FROM `aave_v3_avalanche_c`.`AToken_evt_Initialized`
        

        UNION ALL

        SELECT
            'avalanche_c' AS blockchain
            , contract_address AS atoken_address
            , underlyingAsset AS underlying_address
            , debtTokenDecimals AS atoken_decimals
            , 'Borrow' AS side
            , 'Stable' AS arate_type
            , debtTokenSymbol AS atoken_symbol
            , debtTokenName AS atoken_name
        FROM `aave_v3_avalanche_c`.`StableDebtToken_evt_Initialized`
        WHERE debtTokenName LIKE '%Stable%'
        

        UNION ALL

        SELECT
            'avalanche_c' AS blockchain
            , contract_address AS atoken_address
            , underlyingAsset AS underlying_address
            , debtTokenDecimals AS atoken_decimals
            , 'Borrow' AS side
            , 'Variable' AS arate_type
            , debtTokenSymbol AS atoken_symbol
            , debtTokenName AS atoken_name
        FROM `aave_v3_avalanche_c`.`VariableDebtToken_evt_Initialized`
        WHERE debtTokenName LIKE '%Variable%'
        

        
    
    ) a
LEFT JOIN `tokens`.`erc20` et
    ON a.underlying_address = et.contract_address
    AND a.blockchain = et.blockchain