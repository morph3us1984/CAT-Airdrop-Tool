# CAT-Airdrop-Tool
This simple bash script uses Chia RPC Calls to split and send out CATs to a list of addresses you collected.




Important:
Make sure you have a file called "addresses.txt" with all addresses for this airdrop. It has to be in the same folder as the script itself.
Make sure the addresses are not seperated by commas or space, one address each line. Dont forget to add an empty line with a space at the end of the file. The amount of coins to be split depends on the amount of addresses in this file. 




CAUTION!!!!!
I have no checks in place for existence of this file. Also, I have no checks if an amount of CAT was already sent out.

The script creates a file named cat-airdrop.log in the same folder. If the script crashes or you have to kill it, you can check there which transaction was successfull to that point. If you start the tool again, it will overwrite this file!
CAUTION!!!!!




In the Config Section within the script, you can change settings to fit your system and wallet. It looks like this:

#######################################################################################

#START OF CONFIG SECTION

#Your CAT Wallet Fingerprint

SENDWALLETFINGERPRINT="<YOUR_WALLET_FINGERPRINT>" #for Example: 1234567890

#Your CATs Wallet ID

ID="<CAT_WALLET_ID>" #Your CAT wallet ID (default ID is 2 if it is the only CAT you have in that wallet)

#Your CAT Wallet Address

OWNADDRESS="<WALLET_ADDRESS>" #first CHIA/XCH wallet address of the wallet that holds your CAT. Your Tokens will be send (split) back to that wallet first

#The actual Amount of Tokens you want to send out for each individual Transaction

AMOUNTOFCOINSTOSEND="1"

#Fees in mojo if needed

FEE="0"

#END OF CONFIG SECTION

########################################################################################


If you found this tool helpful, consider donating (10% goes to Childrens Cancer Research):
CHIA: xch1mck7cvljketqgzgrxkmuatl2hmz5f3f435tc095hu0gpkm70af3qgy28kk
