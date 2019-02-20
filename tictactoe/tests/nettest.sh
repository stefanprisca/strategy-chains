#Import all the required scripts
. scripts/ccman.sh
. scripts/utils.sh

# bring up the network

channelname="tttchannel"
yes | ./ttt.sh up -c $channelname

ccgit="github.com/stefanprisca/strategy-code"
ccname="tictactoe"

# install and init tictactoe chaincode
docker exec -i cli /bin/bash -c "scripts/ccman.sh install $ccname $ccgit"
docker exec -i cli /bin/bash -c "scripts/ccman.sh instantiate $ccname $channelname"

# invoke chaincode
docker exec -i cli /bin/bash -c "scripts/ccman.sh invoke $ccname $channelname 11 X 1"

# bring down the network
yes | ./ttt.sh -m down -c tttchannel
