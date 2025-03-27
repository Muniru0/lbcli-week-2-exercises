# Create a new Bitcoin address, for receiving change.
CHANGE_ADDR=$(bitcoin-cli -regtest -rpcwallet=btrustwallet getnewaddress "SegWit Address" bech32)