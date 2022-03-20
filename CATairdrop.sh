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
##########################################################################################
#START OF CONFIG SECTION
#Your CAT Wallet Fingerprint
SENDWALLETFINGERPRINT="<YOUR_WALLET_FINGERPRINT>" #for Example: 1234567890
#Your CATs Wallet ID
ID="<CAT_WALLET_ID" #Your CAT wallet ID
#Depending on the Amount of Transactions you have to send out for the Airdrop, you have to split your Coins(Tokens) first to send them out.
TRANSACTIONAMOUNT="2" #how many transaction?
#Your CAT Wallet Address
OWNADDRESS="<WALLET_ADDRESS>" #first CHIA/XCH wallet address of the wallet that holds your CAT
#The actual Amount of Tokens you want to send out for each individual Transaction
AMOUNTOFCOINSTOSEND="1"
#Fees in mojo if needed
FEE="0"
#END OF CONFIG SECTION
###########################################################################################
AMOUNT=$((AMOUNTOFCOINSTOSEND * 1000)) #Convert to Mojo because one Token is 1000
#OLD METHOD cd ~/chia-blockchain && . ./activate
date
sleep 20s
for i in {1.."$TRANSACTIONAMOUNT"}
do
echo "$AMOUNT"
                                coinsplit="notdone"
                                while [[ "$coinsplit" != "done" ]]
                                do
					echo "Transaction Number $i from $COINAMOUNT"
					until [ `curl -s --insecure --cert ~/.chia/mainnet/config/ssl/full_node/private_full_node.crt --key ~/.chia/mainnet/config/ssl/full_node/private_full_node.key -d '{}' -H "Content-Type: application/json" -X POST https://localhost:9256/get_sync_status | \
 python -m json.tool"" \
 | grep "synced"  \
 | cut -d"\"" -f 3 \
 | cut -d" " -f2 \
 | cut -d"," -f1` == "true" ]
                                        do
                                                echo  -e "${YELLOW}SEND Wallet not synced!${NC}"
                                                sleep 30s
                                        done
                                        #OLD METHOD until [ `chia wallet show -f "$SENDWALLETFINGERPRINT" | grep "Wallet ID $ID" -A3 | grep "Spendable:" | cut -d"(" -f2 | cut -d" " -f1` -ge "$MOJO" ] ;
					until [ `curl -s --insecure --cert ~/.chia/mainnet/config/ssl/full_node/private_full_node.crt --key ~/.chia/mainnet/config/ssl/full_node/private_full_node.key -d '{"wallet_id": '$ID'}' -H "Content-Type: application/json" -X POST https://localhost:9256/get_wallet_balance | python -m json.tool"" | grep "spendable_balance" | cut -d":" -f2 | cut -d" " -f2 |  cut -d"," -f1` -ge "$AMOUNT" ]
					do
                                                echo  -e "${YELLOW}No enough funds yet...waiting 10 Seconds${NC}"
                                                sleep 10s
                                        done
                                        #OLD METHOD testvar=$(chia wallet send -f "$SENDWALLETFINGERPRINT" -i "$ID" -a "$AMOUNT" -t "$ADDRESS" -m "$FEE" | grep -o "submitted")
					testvar=(`curl -s --insecure --cert ~/.chia/mainnet/config/ssl/full_node/private_full_node.crt --key ~/.chia/mainnet/config/ssl/full_node/private_full_node.key -d '{"wallet_id": '$ID',"amount": '$AMOUNT',"fee": '$FEE',"inner_address": "'$OWNADDRESS'"}' -H "Content-Type: application/json" -X POST https://localhost:9256/cat_spend | python -m json.tool"" | grep "success" | cut -d":" -f2 | cut -d" " -f2 | cut -d"," -f1`)
					if [ -z "$testvar" ]
                                        then
                                                echo -e "${RED}Error sending out PAYMENT, trying again...${NC}"
                                                sleep 10s
                                        elif [ "$testvar" == "true" ]
                                        then
						echo -e "${GREEN}PAYMENT Transaction worked${NC}"
                                                coinsplit="done"
                                                sleep 10s
                                        fi
                                done
done
TRANSACTIONS=($(cat addresses.txt))
for address in "${TRANSACTIONS[@]}"
do
				transactionstatus="notdone"
                                while [[ "$transactionstatus" != "done" ]]
                                do
                                        echo "Address to use for this transaction: $address"
                                        until [ `curl -s --insecure --cert ~/.chia/mainnet/config/ssl/full_node/private_full_node.crt --key ~/.chia/mainnet/config/ssl/full_node/private_full_node.key -d '{}' -H "Content-Type: application/json" -X POST https://localhost:9256/get_sync_status | \
 python -m json.tool"" \
 | grep "synced"  \
 | cut -d"\"" -f 3 \
 | cut -d" " -f2 \
 | cut -d"," -f1` == "true" ]
                                        do
                                                echo  -e "${YELLOW}SEND Wallet not synced!${NC}"
                                                sleep 30s
                                        done
                                        #OLD METHOD until [ `chia wallet show -f "$SENDWALLETFINGERPRINT" | grep "Wallet ID $ID" -A3 | grep "Spendable:" | cut -d"(" -f2 | cut -d" " -f1` -ge "$MOJO" ] ;
                                        until [ `curl -s --insecure --cert ~/.chia/mainnet/config/ssl/full_node/private_full_node.crt --key ~/.chia/mainnet/config/ssl/full_node/private_full_node.key -d '{"wallet_id": '$ID'}' -H "Content-Type: application/json" -X POST https://localhost:9256/get_wallet_balance | python -m json.tool"" | grep "spendable_balance" | cut -d":" -f2 | cut -d" " -f2 |  cut -d"," -f1` -ge "$AMOUNT" ]
					do
                                                echo  -e "${YELLOW}No enough funds yet...waiting 10 Seconds${NC}"
                                                sleep 10s
                                        done
                                        #OLD METHOD testvar=$(chia wallet send -f "$SENDWALLETFINGERPRINT" -i "$ID" -a "$AMOUNT" -t "$ADDRESS" -m "$FEE" | grep -o "submitted")
                                        testvar=(`curl -s --insecure --cert ~/.chia/mainnet/config/ssl/full_node/private_full_node.crt --key ~/.chia/mainnet/config/ssl/full_node/private_full_node.key -d '{"wallet_id": '$ID',"amount": '$AMOUNT',"fee": '$FEE',"inner_address": "'$address'"}' -H "Content-Type: application/json" -X POST https://localhost:9256/cat_spend | python -m json.tool"" | grep "success" | cut -d":" -f2 | cut -d" " -f2 | cut -d"," -f1`)
                                        if [ -z "$testvar" ]
					then
                                                echo -e "${RED}Error sending out PAYMENT, trying again...${NC}"
                                                sleep 10s
                                        elif [ "$testvar" == "true" ]
                                        then
                                                echo -e "${GREEN}PAYMENT Transaction worked${NC}"
                                                transactionstatus="done"
                                                sleep 10s
                                        fi
                                done
done
#OLD METHOD deactivate && cd ~/cat-airdrop
date
echo "Script ended"
