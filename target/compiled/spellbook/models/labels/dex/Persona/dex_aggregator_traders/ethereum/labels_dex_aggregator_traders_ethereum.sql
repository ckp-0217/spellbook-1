

with
 dex_traders as (
    select distinct taker as address
    from `dex_aggregator`.`trades`
    where blockchain = 'ethereum'
  )
select
  "ethereum" as blockchain,
  address,
  "DEX Aggregator Trader" AS name,
  "dex" AS category,
  "gentrexha" AS contributor,
  "query" AS source,
  timestamp('2022-12-14') as created_at,
  now() as updated_at,
  "dex_aggregator_traders" as model_name,
  "persona" as label_type
from
  dex_traders