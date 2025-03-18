#!/bin/bash

MINTER_IDENTITY_NAME=$1

DEFAULT_ACCOUNT_NAME="swapy-default-account"

DEFAULT_ACCOUNT_PRINCIPAL=$(dfx identity get-principal --identity=$DEFAULT_ACCOUNT_NAME)

if [ -z "$DEFAULT_ACCOUNT_PRINCIPAL" ]; then
    echo "No principal found. Creating new identity..."
    dfx identity new $DEFAULT_ACCOUNT_NAME
else
    echo "Default Account Principal found: $DEFAULT_ACCOUNT_PRINCIPAL"
fi

dfx identity use $MINTER_IDENTITY_NAME

export MINTER_ACCOUNT_ID=$(dfx ledger account-id)
echo "Minter account ID: $MINTER_ACCOUNT_ID"

dfx identity use $DEFAULT_ACCOUNT_NAME

export DEFAULT_ACCOUNT_ID=$(dfx ledger account-id)
echo "Default account ID: $DEFAULT_ACCOUNT_ID"

dfx deploy --specified-id ryjl3-tyaaa-aaaaa-aaaba-cai icp_ledger --argument "
  (variant {
    Init = record {
      minting_account = \"$MINTER_ACCOUNT_ID\";
      initial_values = vec {
        record {
          \"$DEFAULT_ACCOUNT_ID\";
          record {
            e8s = 10_000_000_000 : nat64;
          };
        };
      };
      send_whitelist = vec {};
      transfer_fee = opt record {
        e8s = 10_000 : nat64;
      };
      token_symbol = opt \"LICP\";
      token_name = opt \"Local ICP\";
    }
  })
"
