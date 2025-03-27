# Create a transaction whose fee can be later updated to a higher fee if it is stuck or doesn't get mined on time

# Amount of 20,000,000 satoshis to this address: 2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP 
# Use the UTXOs from the transaction below
# raw_tx="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"


#!/usr/bin/env bash

# The two UTXOs from your old transaction:
PREV_TXID="23c19f37d4e92e9a115aab86e4edc1b92a51add4e0ed0034bb166314dde50e16"
VOUT_0=0
VOUT_1=1

# Destination and amounts:
DEST_ADDR="2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP"
DEST_AMOUNT="0.20000000"     # 0.2 BTC (20,000,000 sat)
CHANGE_ADDR=$(bitcoin-cli -regtest -rpcwallet=btrustwallet getnewaddress "SegWit Address" bech32)  # Must be in your wallet
CHANGE_AMOUNT="0.03678108"   # leftover after paying 0.2 BTC + 0.00001000 BTC fee

# Construct inputs array with RBF (sequence < 0xffffffff)
# For example, we use 0xfffffffd = 4294967293
inputs=$(cat <<EOF
[
  {
    "txid": "$PREV_TXID",
    "vout": $VOUT_0,
    "sequence": 4294967293
  },
  {
    "txid": "$PREV_TXID",
    "vout": $VOUT_1,
    "sequence": 4294967293
  }
]
EOF
)

# Construct outputs object
outputs=$(cat <<EOF
{
  "$DEST_ADDR": $DEST_AMOUNT,
  "$CHANGE_ADDR": $CHANGE_AMOUNT
}
EOF
)

unsigned_hex="$(
  bitcoin-cli -regtest createrawtransaction \
    "$inputs" \
    "$outputs"
)"
echo "$unsigned_hex"
