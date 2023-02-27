

SELECT *
FROM 
(
      SELECT
            reserve,
            symbol,
            hour,
            deposit_apy,
            stable_borrow_apy,
            variable_borrow_apy
      FROM `aave_v3_optimism`.`interest`
      /*
      UNION ALL
      < add new version as needed
      */
)