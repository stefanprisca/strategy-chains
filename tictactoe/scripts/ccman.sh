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
    INSTARGS='{"Args":[]}'
    
    CHANNEL_NAME="$1"

    echo "================== Instantiating chaincode $CCNAME, on $CHANNEL_NAME with $PERMISSION ==============="

    instantiateChaincode 0 1
    instantiateChaincode 0 2
}

upgradeCC(){
    echo "Not yet implemented."
}

if [ "$MODE" == "install" ]; then # install new sc
    installCC $3
elif [ "$MODE" == "instantiate" ]; then
    instantiateCC $3 $4
elif [ "$MODE" == "unpgrade" ]; then # upgrade the sc
    upgradeCC
fi