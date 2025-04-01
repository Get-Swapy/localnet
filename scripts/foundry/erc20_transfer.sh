#!/bin/bash

# Parse named arguments
for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)
   VALUE=$(echo $ARGUMENT | cut -f2 -d=)

   case "$KEY" in
        contract_address)   CONTRACT_ADDRESS=${VALUE} ;;
        address)            ADDRESS=${VALUE} ;;
        amount)             AMOUNT=${VALUE} ;;
        *)
   esac
done

# Check if required arguments are provided
if [ -z "$CONTRACT_ADDRESS" ] || [ -z "$ADDRESS" ] || [ -z "$AMOUNT" ]; then
    echo "Usage: npm run erc20:transfer contract_address=CONTRACT_ADDRESS address=ADDRESS amount=AMOUNT"
    echo "Example: npm run erc20:transfer contract_address=0x5FbDB2315678afecb367f032d93F642f64180aa3 address=0x70997970C51812dc3A010C7d01b50e0d17dc79C8 amount=100000000"
    exit 1
fi

# Default private key (first account in Anvil)
PRIVATE_KEY="0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"

# Execute the transfer
echo "Transferring $AMOUNT tokens from contract $CONTRACT_ADDRESS to address $ADDRESS..."

cast send $CONTRACT_ADDRESS "transfer(address,uint256)" $ADDRESS $AMOUNT --rpc-url http://127.0.0.1:8545 --private-key $PRIVATE_KEY

echo "Transfer command executed."