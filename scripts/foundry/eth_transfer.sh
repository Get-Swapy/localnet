#!/bin/bash

# Parse named arguments
for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)
   VALUE=$(echo $ARGUMENT | cut -f2 -d=)

   case "$KEY" in
        address)            ADDRESS=${VALUE} ;;
        amount)             AMOUNT=${VALUE} ;;
        *)
   esac
done

# Check if required arguments are provided
if [ -z "$ADDRESS" ] || [ -z "$AMOUNT" ]; then
    echo "Usage: npm run eth:transfer address=ADDRESS amount=AMOUNT"
    echo "Example: npm run eth:transfer address=0x70997970C51812dc3A010C7d01b50e0d17dc79C8 amount=1000000000000000000"
    exit 1
fi

# Default private key (first account in Anvil)
PRIVATE_KEY="0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"

# Execute the transfer
echo "Transferring $AMOUNT ETH to address $ADDRESS..."

cast send $ADDRESS --value $AMOUNT --rpc-url http://127.0.0.1:8545 --private-key $PRIVATE_KEY

echo "ETH transfer command executed."