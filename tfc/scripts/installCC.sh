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
echo "The Fight for Catan (tfc) install CC"
echo

## Install the necessary chaincodes to run all games..
. scripts/ccman.sh

##
##		INSTALL TTT
##
ccgit="github.com/stefanprisca/strategy-code/tictactoe"
ccname="ttt"

echo
echo "========= Starting to install game chaincodes ${ccname} from ${ccgit} =========== "
echo

installCC $ccgit $ccname

##
##		INSTALL TFC
##
ccgit="github.com/stefanprisca/strategy-code/cmd/tfc"
ccname="tfc"

echo
echo "========= Starting to install game chaincodes ${ccname} from ${ccgit} =========== "
echo

installCC $ccgit $ccname


##
##		INSTALL ALLIANCES
##
ccgit="github.com/stefanprisca/strategy-code/cmd/alliance"
ccname="alliance"

echo
echo "========= Starting to install game chaincodes ${ccname} from ${ccgit} =========== "
echo

installCC $ccgit $ccname


#instantiateCC $CHANNEL_NAME $ccname

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
