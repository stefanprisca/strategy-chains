# import utils
. scripts/utils.sh

installCC(){
    CCGIT="$1"
    CCNAME="$2"
    go get $CCGIT
    CC_SRC_PATH="$CCGIT/$CCNAME"
    LANGUAGE="golang"

    echo "================== Installing chaincode from $CC_SRC_PATH ==============="

    installChaincode 0 1
    installChaincode 0 2
}

instantiateCC(){
    LANGUAGE="golang"

    PERMISSION=''
    INSTARGS='{"Args":["init"]}'
    
    CHANNEL_NAME="$1"
    CCNAME="$2"

    echo "================== Instantiating chaincode $CCNAME, on $CHANNEL_NAME with $PERMISSION ==============="

    instantiateChaincode 0 1
    instantiateChaincode 0 2
}