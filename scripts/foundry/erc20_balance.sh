#!/bin/bash

# Parse named arguments
for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)
   VALUE=$(echo $ARGUMENT | cut -f2 -d=)

   case "$KEY" in
        contract_address)   CONTRACT_ADDRESS=${VALUE} ;;
        address)            ADDRESS=${VALUE} ;;
        *)
   esac
done

# Check if required arguments are provided
if [ -z "$CONTRACT_ADDRESS" ] || [ -z "$ADDRESS" ]; then
    echo "Usage: npm run erc20:balance contract_address=CONTRACT_ADDRESS address=ADDRESS"
    echo "Example: npm run erc20:balance contract_address=0x5FbDB2315678afecb367f032d93F642f64180aa3 address=0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"
    exit 1
fi

# Execute the balance check
echo "Checking ERC20 balance for address $ADDRESS on contract $CONTRACT_ADDRESS..."

cast call $CONTRACT_ADDRESS "balanceOf(address)(uint256)" $ADDRESS --rpc-url http://127.0.0.1:8545

echo "Balance check completed."