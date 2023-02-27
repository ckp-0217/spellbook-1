


 -- https://twitter.com/curvefinance/status/1445129758455603210?lang=en















































WITH dexs AS (

        -- 3pool tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0xb599c3590f42f8f995ecfa0f85d2980b76862fc1'
                WHEN bought_id = 1 THEN '0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e'
                WHEN bought_id = 2 THEN '0x9702230a8ea53601f5cd2dc00fdbc13d4df4a8c7'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0xb599c3590f42f8f995ecfa0f85d2980b76862fc1'
                WHEN sold_id = 1 THEN '0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e'
                WHEN sold_id = 2 THEN '0x9702230a8ea53601f5cd2dc00fdbc13d4df4a8c7'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`3pool_evt_TokenExchange`
            

        UNION ALL 

        -- 3poolV2 tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x130966628846bfd36ff31a822705796e8cb8c18d'
                WHEN bought_id = 1 THEN '0xc7198437980c041c805a1edcba50c1ce5db95118'
                WHEN bought_id = 2 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x130966628846bfd36ff31a822705796e8cb8c18d'
                WHEN sold_id = 1 THEN '0xc7198437980c041c805a1edcba50c1ce5db95118'
                WHEN sold_id = 2 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`3poolV2_evt_TokenExchange`
            

        UNION ALL 

        -- Aavepool tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x47afa96cdc9fab46904a55a6ad4bf6660b53c38a'
                WHEN bought_id = 1 THEN '0x46a51127c3ce23fb7ab1de06226147f446e4a857'
                WHEN bought_id = 2 THEN '0x532e6537fea298397212f09a61e03311686f548e'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x47afa96cdc9fab46904a55a6ad4bf6660b53c38a'
                WHEN sold_id = 1 THEN '0x46a51127c3ce23fb7ab1de06226147f446e4a857'
                WHEN sold_id = 2 THEN '0x532e6537fea298397212f09a61e03311686f548e'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`AavePool_evt_TokenExchange`
            

        UNION ALL 

        -- Aavepool tokenexchange underlying 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0xd586e7f844cea2f87f50152665bcbc2c279d8d70'
                WHEN bought_id = 1 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
                WHEN bought_id = 2 THEN '0xc7198437980c041c805a1edcba50c1ce5db95118'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0xd586e7f844cea2f87f50152665bcbc2c279d8d70'
                WHEN sold_id = 1 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
                WHEN sold_id = 2 THEN '0xc7198437980c041c805a1edcba50c1ce5db95118'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`AavePool_evt_TokenExchangeUnderlying`
            

        UNION ALL 
    
        -- Aavev3 tokenexchange underlying 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0xd586e7f844cea2f87f50152665bcbc2c279d8d70'
                WHEN bought_id = 1 THEN '0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e'
                WHEN bought_id = 2 THEN '0x9702230a8ea53601f5cd2dc00fdbc13d4df4a8c7'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0xd586e7f844cea2f87f50152665bcbc2c279d8d70'
                WHEN sold_id = 1 THEN '0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e'
                WHEN sold_id = 2 THEN '0x9702230a8ea53601f5cd2dc00fdbc13d4df4a8c7'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`aave_v3_evt_TokenExchangeUnderlying`
            

        UNION ALL 

        -- agEURjEUR tokenexchange
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x6fefd97f328342a8a840546a55fdcfee7542f9a8'
                WHEN bought_id = 1 THEN '0x9fb1d52596c44603198fb0aee434fac3a679f702'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x6fefd97f328342a8a840546a55fdcfee7542f9a8'
                WHEN sold_id = 1 THEN '0x9fb1d52596c44603198fb0aee434fac3a679f702'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`agEURjEUR_evt_TokenExchange`
            

        UNION ALL  

        -- arUSD tokenexchange
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x025ab35ff6abcca56d57475249baaeae08419039'
                WHEN bought_id = 1 THEN '0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e'
                WHEN bought_id = 2 THEN '0x9702230a8ea53601f5cd2dc00fdbc13d4df4a8c7'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x025ab35ff6abcca56d57475249baaeae08419039'
                WHEN sold_id = 1 THEN '0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e'
                WHEN sold_id = 2 THEN '0x9702230a8ea53601f5cd2dc00fdbc13d4df4a8c7'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`arUSD_evt_TokenExchange`
            

        UNION ALL 

        -- ATricryptopool tokenexchange
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN bought_id = 1 THEN '0x686bef2417b6dc32c50a3cbfbcc3bb60e1e9a15d'
                WHEN bought_id = 2 THEN '0x53f7c5869a859f0aec3d334ee8b4cf01e3492f21'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 1 THEN '0x686bef2417b6dc32c50a3cbfbcc3bb60e1e9a15d'
                WHEN sold_id = 2 THEN '0x53f7c5869a859f0aec3d334ee8b4cf01e3492f21'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`ATriCryptoPool_evt_TokenExchange`
            

        UNION ALL 

        -- avax3pool tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0xd586e7f844cea2f87f50152665bcbc2c279d8d70'
                WHEN bought_id = 1 THEN '0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e'
                WHEN bought_id = 2 THEN '0x9702230a8ea53601f5cd2dc00fdbc13d4df4a8c7'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0xd586e7f844cea2f87f50152665bcbc2c279d8d70'
                WHEN sold_id = 1 THEN '0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e'
                WHEN sold_id = 2 THEN '0x9702230a8ea53601f5cd2dc00fdbc13d4df4a8c7'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`avax3pool_evt_TokenExchange`
            

        UNION ALL 

        -- axlUSDCUSDC tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0xfab550568c688d5d8a52c7d794cb93edc26ec0ec'
                WHEN bought_id = 1 THEN '0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0xfab550568c688d5d8a52c7d794cb93edc26ec0ec'
                WHEN sold_id = 1 THEN '0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`axlUSDCUSDC_evt_TokenExchange`
            

        UNION ALL 

        -- axlUSDCUSDC_e tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0xfab550568c688d5d8a52c7d794cb93edc26ec0ec'
                WHEN bought_id = 1 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0xfab550568c688d5d8a52c7d794cb93edc26ec0ec'
                WHEN sold_id = 1 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`axlUSDC_USDC_e_evt_TokenExchange`
            

        UNION ALL 

        -- blizz tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x6807ed4369d9399847f306d7d835538915fa749d'
                WHEN bought_id = 1 THEN '0xc25ff1af397b76252d6975b4d7649b35c0e60f69'
                WHEN bought_id = 2 THEN '0x18cb11c9f2b6f45a7ac0a95efd322ed4cf9eeebf'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x6807ed4369d9399847f306d7d835538915fa749d'
                WHEN sold_id = 1 THEN '0xc25ff1af397b76252d6975b4d7649b35c0e60f69'
                WHEN sold_id = 2 THEN '0x18cb11c9f2b6f45a7ac0a95efd322ed4cf9eeebf'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`Blizz_evt_TokenExchange`
            

        UNION ALL 

        -- Curve_DD2_Pool tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x210c2e177b34145c64c4eaccd17aca07d2b86164'
                WHEN bought_id = 1 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x210c2e177b34145c64c4eaccd17aca07d2b86164'
                WHEN sold_id = 1 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`Curve_DD2_Pool_evt_TokenExchange`
            

        UNION ALL 

        -- deBridge_USDC tokenexchange underlying 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x28690ec942671ac8d9bc442b667ec338ede6dfd3'
                WHEN bought_id = 1 THEN '0xd586e7f844cea2f87f50152665bcbc2c279d8d70'
                WHEN bought_id = 2 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
                WHEN bought_id = 3 THEN '0xc7198437980c041c805a1edcba50c1ce5db95118'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x28690ec942671ac8d9bc442b667ec338ede6dfd3'
                WHEN sold_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 2 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 3 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`deBridge_USDC_evt_TokenExchangeUnderlying`
            

        UNION ALL 

        -- defrost h20 tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x026187bdbc6b751003517bcb30ac7817d5b766f8'
                WHEN bought_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x026187bdbc6b751003517bcb30ac7817d5b766f8'
                WHEN sold_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`DefrostH2O_evt_TokenExchange`
            

        UNION ALL 
    
        -- defrost h20 tokenexchange underlying
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x026187bdbc6b751003517bcb30ac7817d5b766f8'
                WHEN bought_id = 1 THEN '0xd586e7f844cea2f87f50152665bcbc2c279d8d70'
                WHEN bought_id = 2 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
                WHEN bought_id = 3 THEN '0xc7198437980c041c805a1edcba50c1ce5db95118'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x026187bdbc6b751003517bcb30ac7817d5b766f8'
                WHEN sold_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 2 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 3 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`DefrostH2O_evt_TokenExchangeUnderlying`
            

        UNION ALL 

        -- eEURjEUR tokenexchange
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0xe1d70994be12b73e76889412b284a8f19b0de56d'
                WHEN bought_id = 1 THEN '0x9fb1d52596c44603198fb0aee434fac3a679f702'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0xe1d70994be12b73e76889412b284a8f19b0de56d'
                WHEN sold_id = 1 THEN '0x9fb1d52596c44603198fb0aee434fac3a679f702'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`eEURjEUR_evt_TokenExchange`
            

        UNION ALL 

        -- frax tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0xd24c2ad096400b6fbcd2ad8b24e7acbc21a1da64'
                WHEN bought_id = 1 THEN '0x5b5cfe992adac0c9d48e05854b2d91c73a003858'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0xd24c2ad096400b6fbcd2ad8b24e7acbc21a1da64'
                WHEN sold_id = 1 THEN '0x5b5cfe992adac0c9d48e05854b2d91c73a003858'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`frax_evt_TokenExchange`
            

        UNION ALL 

        -- frax tokenexchange  underlying
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0xd24c2ad096400b6fbcd2ad8b24e7acbc21a1da64'
                WHEN bought_id = 1 THEN '0xd586e7f844cea2f87f50152665bcbc2c279d8d70'
                WHEN bought_id = 2 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
                WHEN bought_id = 3 THEN '0xc7198437980c041c805a1edcba50c1ce5db95118'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0xd24c2ad096400b6fbcd2ad8b24e7acbc21a1da64'
                WHEN sold_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 2 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 3 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`frax_evt_TokenExchangeUnderlying`
            

        UNION ALL 

        -- FUSD_MIM_Factory_Pool tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0xc6636e205460be6073b65094422910161d767ef2'
                WHEN bought_id = 1 THEN '0x130966628846bfd36ff31a822705796e8cb8c18d'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0xc6636e205460be6073b65094422910161d767ef2'
                WHEN sold_id = 1 THEN '0x130966628846bfd36ff31a822705796e8cb8c18d'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`FUSD_MIM_Factory_Pool_evt_TokenExchange`
            

        UNION ALL 

        -- FUSDUSDC tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0xc6636e205460be6073b65094422910161d767ef2'
                WHEN bought_id = 1 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0xc6636e205460be6073b65094422910161d767ef2'
                WHEN sold_id = 1 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`FUSDUSDC_evt_TokenExchange`
            

        UNION ALL 

        -- l2stableswap tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7'
                WHEN bought_id = 1 THEN '0x6c6f910a79639dcc94b4feef59ff507c2e843929'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7'
                WHEN sold_id = 1 THEN '0x6c6f910a79639dcc94b4feef59ff507c2e843929'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`L2StableSwap_evt_TokenExchange`
            

        UNION ALL 

        -- mai tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x5c49b268c9841aff1cc3b0a418ff5c3442ee3f3b'
                WHEN bought_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x5c49b268c9841aff1cc3b0a418ff5c3442ee3f3b'
                WHEN sold_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`MAI_evt_TokenExchange`
            
        
        UNION ALL 

        -- mai tokenexchange  underlying
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x5c49b268c9841aff1cc3b0a418ff5c3442ee3f3b'
                WHEN bought_id = 1 THEN '0xd586e7f844cea2f87f50152665bcbc2c279d8d70'
                WHEN bought_id = 2 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
                WHEN bought_id = 3 THEN '0xc7198437980c041c805a1edcba50c1ce5db95118'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x5c49b268c9841aff1cc3b0a418ff5c3442ee3f3b'
                WHEN sold_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 2 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 3 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`MAI_evt_TokenExchangeUnderlying`
            

        UNION ALL 

        -- mim tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x130966628846bfd36ff31a822705796e8cb8c18d'
                WHEN bought_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x130966628846bfd36ff31a822705796e8cb8c18d'
                WHEN sold_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`MIM_evt_TokenExchange`
            

        UNION ALL 

        -- mim tokenexchange  underlying
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x130966628846bfd36ff31a822705796e8cb8c18d'
                WHEN bought_id = 1 THEN '0xd586e7f844cea2f87f50152665bcbc2c279d8d70'
                WHEN bought_id = 2 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
                WHEN bought_id = 3 THEN '0xc7198437980c041c805a1edcba50c1ce5db95118'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x130966628846bfd36ff31a822705796e8cb8c18d'
                WHEN sold_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 2 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 3 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`MIM_evt_TokenExchangeUnderlying`
            

        UNION ALL 

        -- MoreMoney_USD tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x0f577433bf59560ef2a79c124e9ff99fca258948'
                WHEN bought_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x0f577433bf59560ef2a79c124e9ff99fca258948'
                WHEN sold_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`MoreMoney_USD_evt_TokenExchange`
            

        UNION ALL  

        -- MoreMoney_USD tokenexchange  underlying
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x0f577433bf59560ef2a79c124e9ff99fca258948'
                WHEN bought_id = 1 THEN '0xd586e7f844cea2f87f50152665bcbc2c279d8d70'
                WHEN bought_id = 2 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
                WHEN bought_id = 3 THEN '0xc7198437980c041c805a1edcba50c1ce5db95118'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x0f577433bf59560ef2a79c124e9ff99fca258948'
                WHEN sold_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 2 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 3 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`MoreMoney_USD_evt_TokenExchangeUnderlying`
            

        UNION ALL  

        -- NXUSDaV3CRV tokenexchange  underlying
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0xf14f4ce569cb3679e99d5059909e23b07bd2f387'
                WHEN bought_id = 1 THEN '0xd586e7f844cea2f87f50152665bcbc2c279d8d70'
                WHEN bought_id = 2 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
                WHEN bought_id = 3 THEN '0xc7198437980c041c805a1edcba50c1ce5db95118'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0xf14f4ce569cb3679e99d5059909e23b07bd2f387'
                WHEN sold_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 2 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 3 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`NXUSDaV3CRV_evt_TokenExchangeUnderlying`
            

        UNION ALL 

        -- ren tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x686bef2417b6dc32c50a3cbfbcc3bb60e1e9a15d'
                WHEN bought_id = 1 THEN '0xdbf31df14b66535af65aac99c32e9ea844e14501'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x686bef2417b6dc32c50a3cbfbcc3bb60e1e9a15d'
                WHEN sold_id = 1 THEN '0xdbf31df14b66535af65aac99c32e9ea844e14501'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`ren_evt_TokenExchange`
            

        UNION ALL 

        -- ren tokenexchange underlying 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x50b7545627a5162f82a992c33b87adc75187b218'
                WHEN bought_id = 1 THEN '0xdbf31df14b66535af65aac99c32e9ea844e14501'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x50b7545627a5162f82a992c33b87adc75187b218'
                WHEN sold_id = 1 THEN '0xdbf31df14b66535af65aac99c32e9ea844e14501'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`ren_evt_TokenExchangeUnderlying`
            

        UNION ALL 

        -- Topshelf_USDL tokenexchange  underlying
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x40b393cecf8f7d7fc79b83e8fa40e850511817f6'
                WHEN bought_id = 1 THEN '0xd586e7f844cea2f87f50152665bcbc2c279d8d70'
                WHEN bought_id = 2 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
                WHEN bought_id = 3 THEN '0xc7198437980c041c805a1edcba50c1ce5db95118'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x40b393cecf8f7d7fc79b83e8fa40e850511817f6'
                WHEN sold_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 2 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 3 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`Topshelf_USDL_evt_TokenExchangeUnderlying`
            

        UNION ALL 

        -- USDCe_UST tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
                WHEN bought_id = 1 THEN '0xb599c3590f42f8f995ecfa0f85d2980b76862fc1'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
                WHEN sold_id = 1 THEN '0xb599c3590f42f8f995ecfa0f85d2980b76862fc1'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`USDCe_UST_evt_TokenExchange`
            

        UNION ALL 

        -- USD coin tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
                WHEN bought_id = 1 THEN '0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
                WHEN sold_id = 1 THEN '0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`USD_coin_evt_TokenExchange`
            

        UNION ALL 

        -- usds tokenexchange  underlying
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0xab05b04743e0aeaf9d2ca81e5d3b8385e4bf961e'
                WHEN bought_id = 1 THEN '0xd586e7f844cea2f87f50152665bcbc2c279d8d70'
                WHEN bought_id = 2 THEN '0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664'
                WHEN bought_id = 3 THEN '0xc7198437980c041c805a1edcba50c1ce5db95118'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0xab05b04743e0aeaf9d2ca81e5d3b8385e4bf961e'
                WHEN sold_id = 1 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 2 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
                WHEN sold_id = 3 THEN '0x1337bedc9d22ecbe766df105c9623922a27963ec'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`USDS_evt_TokenExchangeUnderlying`
            

        UNION ALL 

        -- yusdpool tokenexchange 
        SELECT
            evt_block_time AS block_time,
            '' AS version,
            buyer AS taker,
            '' AS maker,
            tokens_bought AS token_bought_amount_raw,
            tokens_sold AS token_sold_amount_raw,
            CAST(NULL as double) as amount_usd,
            CASE
                WHEN bought_id = 0 THEN '0x111111111111ed1d73f860f57b2798b683f2d325'
                WHEN bought_id = 1 THEN '0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e'
                WHEN bought_id = 2 THEN '0x9702230a8ea53601f5cd2dc00fdbc13d4df4a8c7'
            END as token_bought_address,
            CASE
                WHEN sold_id = 0 THEN '0x111111111111ed1d73f860f57b2798b683f2d325'
                WHEN sold_id = 1 THEN '0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e'
                WHEN sold_id = 2 THEN '0x9702230a8ea53601f5cd2dc00fdbc13d4df4a8c7'
            END as token_sold_address,
            contract_address AS project_contract_address,
            evt_tx_hash AS tx_hash,
            '' AS trace_address,
            evt_index
            FROM `curvefi_avalanche_c`.`YUSDPOOL_evt_TokenExchange`
            
)

SELECT
    'avalanche_c' as blockchain, 
    'curve' as project, 
    '2' as version, 
    TRY_CAST(date_trunc('DAY', dexs.block_time) as date) as block_date, 
    dexs.block_time, 
    erc20a.symbol as token_bought_symbol, 
    erc20b.symbol as token_sold_symbol, 
    CASE
        WHEN lower(erc20a.symbol) > lower(erc20b.symbol) THEN concat(erc20b.symbol, '-', erc20a.symbol)
        ELSE concat(erc20a.symbol, '-', erc20b.symbol)
    END as token_pair, 
    dexs.token_bought_amount_raw / power(10, erc20a.decimals) as token_bought_amount, 
    dexs.token_sold_amount_raw / power(10, erc20b.decimals) as token_sold_amount, 
    CAST(dexs.token_bought_amount_raw AS DECIMAL(38,0)) AS token_bought_amount_raw, 
    CAST(dexs.token_sold_amount_raw AS DECIMAL(38,0)) AS token_sold_amount_raw, 
    COALESCE(
        dexs.amount_usd, 
        (dexs.token_bought_amount_raw / power(10, p_bought.decimals)) * p_bought.price, 
        (dexs.token_sold_amount_raw / power(10, p_sold.decimals)) * p_sold.price
    ) as amount_usd, 
    dexs.token_bought_address, 
    dexs.token_sold_address, 
    COALESCE(dexs.taker, tx.from) as taker,  -- subqueries rely on this COALESCE to avoid redundant joins with the transactions table
    dexs.maker, 
    dexs.project_contract_address, 
    dexs.tx_hash, 
    tx.from as tx_from, 
    tx.to AS tx_to, 
    dexs.trace_address, 
    dexs.evt_index
FROM dexs
INNER JOIN `avalanche_c`.`transactions` tx
    ON tx.hash = dexs.tx_hash
    
    AND tx.block_time >= '2021-09-01 00:00:00'
    
    
LEFT JOIN `tokens`.`erc20` erc20a
    ON erc20a.contract_address = dexs.token_bought_address
    AND erc20a.blockchain = 'avalanche_c'
LEFT JOIN `tokens`.`erc20` erc20b
    ON erc20b.contract_address = dexs.token_sold_address
    AND erc20b.blockchain = 'avalanche_c'
LEFT JOIN `prices`.`usd` p_bought
    ON p_bought.minute = date_trunc('minute', dexs.block_time)
    AND p_bought.contract_address = dexs.token_bought_address
    AND p_bought.blockchain = 'avalanche_c'
    
    AND p_bought.minute >= '2021-09-01 00:00:00'
    
    
LEFT JOIN `prices`.`usd` p_sold
    ON p_sold.minute = date_trunc('minute', dexs.block_time)
    AND p_sold.contract_address = dexs.token_sold_address
    AND p_sold.blockchain = 'avalanche_c'
    
    AND p_sold.minute >= '2021-09-01 00:00:00'
    
    