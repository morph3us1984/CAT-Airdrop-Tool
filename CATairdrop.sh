#!/bin/bash
#CAT Airdrop Tool
#Version 0.1a
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>cat-airdrop.log 2>&1
# Everything below will go to the file 'log.out':
set -o xtrace
echo "Coinsplit script started:"
date
i="0"
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
YELLOW="\e[33m"
NC="\e[0m"
START="1"
pwdtool=$(pwd)
TRANSACTIONAMOUNT=$(cat "$pwdtool"/addresses.txt | wc -l) #how many transactions?
##########################################################################################
#START OF CONFIG SECTION
#Your CAT Wallet Fingerprint
SENDWALLETFINGERPRINT="YOUR_WALLET_FINGERPRINT" #for Example: 1234567890
#Your CATs Wallet ID
ID="YOURWALLET_ID" #Your CAT wallet ID
#Your CAT Wallet Address
OWNADDRESS="<YOUR_OWN_WALLET_ADDRESS_WHERE_COINS_WILL_BE_SPLIT" #first CHIA/XCH wallet address of the wallet that holds your CAT
#The actual Amount of Tokens you want to send out for each individual Transaction
AMOUNTOFCOINSTOSEND="1"
#Fees in mojo if needed, default= 0 Mojo
FEE="0"
#END OF CONFIG SECTION
###########################################################################################
AMOUNT=$((AMOUNTOFCOINSTOSEND * 1000)) #Convert to Mojo because one Token is 1000
cd ~/chia-blockchain && . ./activate
date
sleep 5s
for (( c=$START; c<=$TRANSACTIONAMOUNT; c++ ))
do
echo "$AMOUNT"
                                coinsplit="notdone"
                                while [[ "$coinsplit" != "done" ]]
                                do
                                        echo "Transaction Number $c from $TRANSACTIONAMOUNT"
                                        until [ `chia rpc wallet get_sync_status  | grep "synced"   | cut -d"\"" -f 3  | cut -d" " -f2  | cut -d"," -f1` == "true" ];
                                        do
                                                echo  -e "${YELLOW}SEND Wallet not synced!${NC}"
                                                sleep 30s
                                        done
                                        until [ `chia rpc wallet get_wallet_balance '{"wallet_id": '$ID'}' | grep "spendable_balance" | cut -d ":" -f 2 | cut -d " " -f2 | cut -d "," -f1` -ge "$AMOUNT" ] ;
                                        do
                                                echo  -e "${YELLOW}No enough funds yet...waiting 10 Seconds${NC}"
                                                sleep 10s
                                        done
                                        output=$(chia rpc wallet cat_spend '{"fingerprint": '$SENDWALLETFINGERPRINT',"wallet_id": '$ID',"amount": '$AMOUNT',"fee": '$FEE',"inner_address": "'$OWNADDRESS'"}')
                                        result=$(echo "$output" | grep "success" | cut -d ":" -f 2 | cut -d " " -f 2 | cut -d "," -f 1)
                                        if [ "$result" != "true" ]
                                        then
                                                echo -e "${RED}Error sending out PAYMENT, trying again...${NC}"
                                                echo -e "Error: ${output}"
                                                sleep 10s
                                        elif [ "$result" == "true" ]
                                        then
                                                echo -e "${GREEN}PAYMENT Transaction worked${NC}"
                                                coinsplit="done"
                                        fi
                                done
done
TRANSACTIONS=($(cat "$pwdtool"/addresses.txt))
for address in "${TRANSACTIONS[@]}"
do
                                transactionstatus="notdone"
                                while [[ "$transactionstatus" != "done" ]]
                                do
                                        echo "Address to use for this transaction: $address"
                                        until [ `chia rpc wallet get_sync_status  | grep "synced"   | cut -d"\"" -f 3  | cut -d" " -f2  | cut -d"," -f1` == "true" ];
                                        do
                                                echo  -e "${YELLOW}SEND Wallet not synced!${NC}"
                                                sleep 30s
                                        done
                                        until [ `chia rpc wallet get_wallet_balance '{"wallet_id": '$ID'}' | grep "spendable_balance" | cut -d ":" -f 2 | cut -d " " -f2 | cut -d "," -f1` -ge "$AMOUNT" ] ;
                                        do
                                                echo  -e "${YELLOW}No enough funds yet...waiting 10 Seconds${NC}"
                                                sleep 10s
                                        done
                                        output=$(chia rpc wallet cat_spend '{"fingerprint": '$SENDWALLETFINGERPRINT',"wallet_id": '$ID',"amount": '$AMOUNT',"fee": '$FEE',"inner_address": "'$address'"}')
                                        result=$(echo "$output" | grep "success" | cut -d ":" -f 2 | cut -d " " -f 2 | cut -d "," -f 1)
                                        if [ "$result" != "true" ]
                                        then
                                                echo -e "${RED}Error sending out PAYMENT, trying again...${NC}"
                                                echo -e "Error: ${output}"
                                                sleep 10s
                                        elif [ "$result" == "true" ]
                                        then
                                                echo -e "${GREEN}PAYMENT Transaction worked${NC}"
                                                transactionstatus="done"
                                        fi
                                done
done
deactivate && cd -
date
echo "Script ended"
