

select event_type
        , punk_id
        , from
        , to
        , eth_amount
        , eth_amount * p.price as usd_amount
        , evt_block_time
        , evt_block_time_week
        , evt_block_number
        , evt_index
        , evt_tx_hash
from 
(
        select  'Offered' as event_type
            , punkIndex as punk_id
            , b.from 
            , case when toAddress = '0x0000000000000000000000000000000000000000' then cast(NULL as varchar(5))
                else toAddress end as to
            , minValue/1e18 as eth_amount
            , a.evt_block_time 
            , date_trunc('week',a.evt_block_time) as evt_block_time_week
            , a.evt_block_number
            , a.evt_index
            , a.evt_tx_hash
        from `cryptopunks_ethereum`.`CryptoPunksMarket_evt_PunkOffered` a
        inner join `ethereum`.`transactions` b
                on a.evt_tx_hash = b.hash
                
        

        union all 

        select  'Offer Withdrawn' as event_type
                , a.punkIndex
                , b.from  
                , cast(NULL as varchar(5)) as to 
                , cast(NULL as double) as eth_amount
                , a.evt_block_time
                , date_trunc('week',a.evt_block_time) as evt_block_time_week
                , a.evt_block_number
                , a.evt_index
                , a.evt_tx_hash
        from `cryptopunks_ethereum`.`CryptoPunksMarket_evt_PunkNoLongerForSale` a
        inner join `ethereum`.`transactions` b
                on a.evt_tx_hash = b.hash
                
        where a.evt_tx_hash not in (select distinct tx_hash from `cryptopunks_ethereum`.`trades` )
                and a.evt_tx_hash not in (select distinct evt_tx_hash from `cryptopunks_ethereum`.`punk_transfers` )
                
) a 
left join `prices`.`usd` p on p.minute = date_trunc('minute', a.evt_block_time)
        and p.contract_address = '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2'
        and p.blockchain = 'ethereum'
        
;