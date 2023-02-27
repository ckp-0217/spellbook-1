

select distinct token_address
from `transfers_ethereum`.`erc20_rolling_day`
where round(amount/power(10, 18), 6) < -0.001