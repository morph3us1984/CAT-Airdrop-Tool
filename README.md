# CAT-Airdrop-Tool
This simple bash script uses Chia RPC Calls to split and send out CATs to a list of addresses you collected.




Important:
Make sure you have a file called "addresses.txt" with all addresses for this airdrop. It has to be in the same folder as the script itself.
Make sure the addresses are not seperated by commas or space, one address each line.




CAUTION!!!!!
I have no checks in place for existens of this file. Also, I have no checks if an amount of CATs was already sent out.

The script creates a file named cat-airdrop.log in the same folder. If the script crashes or you have to kill it, you can check there which transaction was successfull to that point.
CAUTION!!!!!




In the Config Section you can change settings to fit your system and wallet

#######################################################################################

#START OF CONFIG SECTION

#Your CAT Wallet Fingerprint

SENDWALLETFINGERPRINT="<YOUR_WALLET_FINGERPRINT>" #for Example: 1234567890

#Your CATs Wallet ID

ID="<CAT_WALLET_ID>" #Your CAT wallet ID (default ID is 2 if it is the only CAT you have in that Wallet)

#Depending on the Amount of Transactions you have to send out for the Airdrop, you have to split your Coins(Tokens) first to send them out.

TRANSACTIONAMOUNT="2" #how many transaction?

#Your CAT Wallet Address

OWNADDRESS="<WALLET_ADDRESS>" #first CHIA/XCH wallet address of the wallet that holds your CAT

#The actual Amount of Tokens you want to send out for each individual Transaction

AMOUNTOFCOINSTOSEND="1"

#Fees in mojo if needed

FEE="0"

#END OF CONFIG SECTION

########################################################################################
