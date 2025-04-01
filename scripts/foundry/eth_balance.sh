#!/bin/bash

# Parse named arguments
for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)
   VALUE=$(echo $ARGUMENT | cut -f2 -d=)

   case "$KEY" in
        address)            ADDRESS=${VALUE} ;;
        *)
   esac
done

# Check if required arguments are provided
if [ -z "$ADDRESS" ]; then
    echo "Usage: npm run eth:balance address=ADDRESS"
    echo "Example: npm run eth:balance address=0x70997970C51812dc3A010C7d01b50e0d17dc79C8"
    exit 1
fi

# Execute the balance check
echo "Checking ETH balance for address $ADDRESS..."

cast balance $ADDRESS --rpc-url http://127.0.0.1:8545

echo "Balance check completed."