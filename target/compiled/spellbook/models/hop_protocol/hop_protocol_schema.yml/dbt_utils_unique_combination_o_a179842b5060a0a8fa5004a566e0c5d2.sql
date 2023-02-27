





with validation_errors as (

    select
        blockchain, l1CanonicalToken, l1Bridge, l1CanonicalBridge, bridgeDeployedBlockNumber, l2CanonicalToken, l2Bridge, l2HopBridgeToken, l2SaddleSwap, l2SaddleLpToken
    from `hop_protocol`.`addresses`
    group by blockchain, l1CanonicalToken, l1Bridge, l1CanonicalBridge, bridgeDeployedBlockNumber, l2CanonicalToken, l2Bridge, l2HopBridgeToken, l2SaddleSwap, l2SaddleLpToken
    having count(*) > 1

)

select *
from validation_errors


