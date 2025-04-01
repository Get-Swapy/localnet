#!/bin/bash

# Parse named arguments
for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)
   VALUE=$(echo $ARGUMENT | cut -f2 -d=)

   case "$KEY" in
        canister_name)      CANISTER_NAME=${VALUE} ;;
        canister_id)        CANISTER_ID=${VALUE} ;;
        user_id)            USER_ID=${VALUE} ;;
        *)
   esac
done

# Check if required arguments are provided
if [ -z "$CANISTER_NAME" ] || [ -z "$CANISTER_ID" ]; then
    echo "Usage: npm run icrc:balance canister_name=CANISTER_NAME canister_id=CANISTER_ID [user_id=USER_ID]"
    echo "Example: npm run icrc:balance canister_name=icp_ledger canister_id=bd3sg-teaaa-aaaaa-qaaba-cai user_id=79ae33a4-ab4d-4e86-ba95-37e7245770b1"
    echo "Note: user_id is optional. If not provided, subaccount will be null."
    exit 1
fi

# Function to convert UUID to Uint8Array representation for ICRC-1
convert_uuid_to_subaccount() {
    local uuid=$1
    # Remove hyphens from UUID
    local clean_uuid=$(echo $uuid | tr -d '-')
    
    # Convert to semicolon-separated ASCII values
    local result=""
    for (( i=0; i<${#clean_uuid}; i++ )); do
        char="${clean_uuid:$i:1}"
        ascii=$(printf "%d" "'$char")
        result+="$ascii;"
    done
    
    # Remove trailing semicolon
    result=${result%;}
    
    # Pad with zeros if needed (to make 32 bytes)
    local count=$(echo $result | tr -cd ';' | wc -c)
    count=$((count + 1)) # Number of elements
    
    if [ $count -lt 32 ]; then
        for (( i=count; i<32; i++ )); do
            result+=";0"
        done
    fi
    
    echo $result
}

# Execute the balance check
echo "Checking ICRC balance for principal $CANISTER_ID on canister $CANISTER_NAME..."

if [ -z "$USER_ID" ]; then
    # If no user_id is provided, use null for subaccount
    dfx canister call $CANISTER_NAME icrc1_balance_of "
      (record {
        owner = principal \"$CANISTER_ID\";
        subaccount = null;
      })
    "
else
    # Convert UUID to subaccount format
    SUBACCOUNT=$(convert_uuid_to_subaccount $USER_ID)
    
    dfx canister call $CANISTER_NAME icrc1_balance_of "
      (record {
        owner = principal \"$CANISTER_ID\";
        subaccount = opt vec {$SUBACCOUNT};
      })
    "
fi

echo "Balance check completed."