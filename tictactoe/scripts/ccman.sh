MODE="$1"
CCNAME="$2"

# import utils
. scripts/utils.sh

installCC(){
    CCGIT="$1"
    go get $CCGIT
    CC_SRC_PATH="$CCGIT/$CCNAME"
    LANGUAGE="golang"

    echo "================== Installing chaincode from $CC_SRC_PATH ==============="

    installChaincode 0 1
    installChaincode 0 2
}

instantiateCC(){
    LANGUAGE="golang"

    PERMISSION='AND ("Player1MSP.peer","Player2MSP.peer")'
    INSTARGS='{"Args":["init"]}'
    
    CHANNEL_NAME="$1"

    echo "================== Instantiating chaincode $CCNAME, on $CHANNEL_NAME with $PERMISSION ==============="

    instantiateChaincode 0 1
    instantiateChaincode 0 2
}

upgradeCC(){
    echo "Not yet implemented."
}

invokeCC(){

    CHANNEL_NAME="$1"
    posId="$2"
    mark="$3"
    player=$4

    INVOKARGS="{\"Args\":[\"move\",\"$posId\",\"$mark\"]}"
    echo "================== Invoking move: $INVOKARGS, $player, $CHANNEL_NAME ==============="

    chaincodeInvoke 0 $player
}

queryCC(){

    CHANNEL_NAME="$1"
    posId="$2"
    player=$3
    expectedM=$4

    QARGS="{\"Args\":[\"getPos\",\"$posId\"]}"
    echo "================== Invoking move: $INVOKARGS ==============="

    chaincodeInvoke 0 $player
}

if [ "$MODE" == "install" ]; then # install new sc
    installCC $3
elif [ "$MODE" == "instantiate" ]; then
    instantiateCC $3 $4
elif [ "$MODE" == "unpgrade" ]; then # upgrade the sc
    upgradeCC
elif [ "$MODE" == "invoke" ]; then # upgrade the sc
    invokeCC $3 $4 $5 $6
elif [ "$MODE" == "query" ]; then # upgrade the sc
    queryCC
fi