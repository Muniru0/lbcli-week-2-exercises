# Created a SegWit address.
addr=$(bitcoin-cli -regtest -rpcwallet=btrustwallet getnewaddress "SegWit Address" bech32)

# Add funds to the address.
funding=$(bitcoin-cli -regtest -rpcwallet=btrustwallet generatetoaddress 106 "$addr")

# Return only the Address
echo "$addr"