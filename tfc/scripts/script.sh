#!/bin/bash
# Copyright 2019 Stefan Prisca

# This script is a copy of the Hyperledger byfn script, with modifications to fit the tic tac toe project.
# original can be found here: <https://github.com/hyperledger/fabric-samples/blob/release-1.4/first-network/scripts/script.sh>

echo
echo " ____    _____      _      ____    _____ "
echo "/ ___|  |_   _|    / \    |  _ \  |_   _|"
echo "\___ \    | |     / _ \   | |_) |   | |  "
echo " ___) |   | |    / ___ \  |  _ <    | |  "
echo "|____/    |_|   /_/   \_\ |_| \_\   |_|  "
echo
echo "The Fight for Catan (tfc) end-to-end build"
echo
CHANNEL_NAME="$1"
DELAY="$2"
LANGUAGE="$3"
TIMEOUT="$4"
VERBOSE="$5"
DEMO_CC="$6"
: ${CHANNEL_NAME:="tfcchannel"}
: ${DELAY:="3"}
: ${LANGUAGE:="golang"}
: ${TIMEOUT:="10"}
: ${VERBOSE:="false"}
LANGUAGE=`echo "$LANGUAGE" | tr [:upper:] [:lower:]`
COUNTER=1
MAX_RETRY=10

echo "Channel name : "$CHANNEL_NAME

# import utils
. scripts/utils.sh

createChannel() {
	setGlobals 0 1

	if [ -z "$CORE_PEER_TLS_ENABLED" -o "$CORE_PEER_TLS_ENABLED" = "false" ]; then
                set -x
		peer channel create -o orderer.tfc.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/$CHANNEL_NAME.tx >&log.txt
		res=$?
                set +x
	else
				set -x
		peer channel create -o orderer.tfc.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/$CHANNEL_NAME.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA >&log.txt
		res=$?
				set +x
	fi
	cat log.txt
	verifyResult $res "Channel creation failed"
	echo "===================== Channel '$CHANNEL_NAME' created ===================== "
	echo
}

joinChannel () {
	for player in 1 2; do
	    for peer in 0; do
		joinChannelWithRetry $peer $player
		echo "===================== peer${peer}.org${player} joined channel '$CHANNEL_NAME' ===================== "
		sleep $DELAY
		echo
	    done
	done
}

## Create channel
echo "Creating channel..."
createChannel

## Join all the peers to the channel
echo "Having all peers join the channel..."
joinChannel

## Set the anchor peers for each player in the channel
echo "Updating anchor peers for player1..."
updateAnchorPeers 0 1
echo "Updating anchor peers for player2..."
updateAnchorPeers 0 2


## Install and initiate a chaincode to see if it works.
. scripts/ccman.sh
ccgit="github.com/stefanprisca/strategy-code"
ccname="tictactoe"

# install and init tictactoe chaincode
installCC $ccgit $ccname
instantiateCC $CHANNEL_NAME $ccname

# # invoke chaincode
# # Don't know how to invoke with protobuf arguments.
# docker exec -i cli /bin/bash -c "scripts/ccman.sh invoke $ccname $channelname 11 X 1"

echo
echo "========= All GOOD, tfc execution completed =========== "
echo

echo
echo " _____   _   _   ____   "
echo "| ____| | \ | | |  _ \  "
echo "|  _|   |  \| | | | | | "
echo "| |___  | |\  | | |_| | "
echo "|_____| |_| \_| |____/  "
echo

exit 0
