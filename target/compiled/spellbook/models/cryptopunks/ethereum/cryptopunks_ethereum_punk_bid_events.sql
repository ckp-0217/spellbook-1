

select  event_type
        , punk_id
        , bidder 
        , eth_amount
        , eth_amount * p.price as usd_amount
        , evt_block_time
        , evt_block_time_week
        , evt_block_number
        , evt_index
        , evt_tx_hash
from 
(       select  'Bid Entered' as event_type
                , punkIndex as punk_id
                , fromAddress as bidder
                , value/1e18 as eth_amount
                , evt_block_time
                , date_trunc('week',evt_block_time) as evt_block_time_week
                , evt_block_number
                , evt_index
                , evt_tx_hash 
        from `cryptopunks_ethereum`.`CryptoPunksMarket_evt_PunkBidEntered`
        

        union all 

        select  'Bid Withdrawn' as event_type
                , punkIndex as punk_id
                , fromAddress as bidder
                , value/1e18 as eth_amount
                , evt_block_time
                , date_trunc('week',evt_block_time) as evt_block_time_week
                , evt_block_number
                , evt_index
                , evt_tx_hash 
        from `cryptopunks_ethereum`.`CryptoPunksMarket_evt_PunkBidWithdrawn`
        
) a 
left join `prices`.`usd` p on p.minute = date_trunc('minute', a.evt_block_time)
        and p.contract_address = '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2'
        and p.blockchain = 'ethereum'
        
;