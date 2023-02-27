

select punk_id
        , to as current_owner
        , evt_block_time as last_transfer_time
from 
(       select *
                , row_number() over (partition by punk_id order by evt_block_number desc, evt_index desc) as punk_id_tx_rank
        from  `cryptopunks_ethereum`.`punk_transfers`
) a
where punk_id_tx_rank = 1 
order by cast(punk_id as int) asc
;