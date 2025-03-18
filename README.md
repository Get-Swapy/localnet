# Localnet for Swapy

## ICRC-1 Transfers

To perform transfers using ICRC-1 tokens, you can use the following script:

```bash
dfx canister call ICRC1_CANISTER_NAME icrc1_transfer "
  (record {
    to = record {
      owner = principal \"TARGET_PRINCIPAL_ID\";
      subaccount = opt vec {UINT8ARRAY_OF_32_BYTES};
    };
    amount = AMOUNT_TO_TRANSFER
  })
"
```

Here's an example of how to perform an ICRC-1 transfer:

```bash
dfx canister call icp_ledger icrc1_transfer "
  (record {
    to = record {
      owner = principal \"bkyz2-fmaaa-aaaaa-qaaaq-cai\";
      subaccount = opt vec {55;100;53;56;101;53;52;55;99;97;97;99;52;53;102;51;56;48;55;54;53;48;56;102;48;101;57;98;50;53;56;50};
    };
    amount = 1_000_000
  })
"
```
