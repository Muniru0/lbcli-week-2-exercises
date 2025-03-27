# Create a raw transaction with an amount of 20,000,000 satoshis to this address: 2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP 
# Use the UTXOs from the transaction below
# raw_tx="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"



# 1) Decode the raw transaction to extract the TXID
PREV_TXID=$(bitcoin-cli -regtest decoderawtransaction "01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000" | jq -r '.txid')

# 2) UTXO input indices
VOUT_0=0
VOUT_1=1

# 3) Destination address (testnet P2SH)
DEST_ADDR="2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP"
DEST_AMOUNT="0.20000000"  # 20,000,000 sats

# 4) Create the raw transaction using both inputs, no change output, and enable RBF
unsigned_hex="$(
  bitcoin-cli -regtest -rpcwallet=btrustwallet createrawtransaction \
    "[
       {\"txid\":\"$PREV_TXID\",\"vout\":$VOUT_0, \"sequence\": 1},
       {\"txid\":\"$PREV_TXID\",\"vout\":$VOUT_1, \"sequence\": 1}
     ]" \
    "{
       \"$DEST_ADDR\": $DEST_AMOUNT
     }"
)"

# 5) Output the hex
echo "$unsigned_hex"

