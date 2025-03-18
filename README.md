# Localnet for Swapy

## Setup

### Manual Setup

Ensure the following are installed on your system:

- [Node.js](https://nodejs.org/en/) `>= 22`
- [Foundry](https://github.com/foundry-rs/foundry)
- [Caddy](https://caddyserver.com/docs/install#install)
- [DFX](https://internetcomputer.org/docs/current/developer-docs/build/install-upgrade-remove) `>= 0.25.0`

Run these commands in a new, empty project directory:

```sh
git clone https://github.com/Get-Swapy/localnet.git
cd localnet
npm install
```

## Getting started

No matter what setup you pick from below, run `npm run ic:start` from the project root to deploy the project. To understand the steps involved in deploying the `chain_fusion` locally, examine the comments in `scripts/ic/start.sh`. This script will:

- start icp local replica
- deploy the evm_rpc
- deploy the chain_fusion

### Start Local Ethereum Node

For a local development you can use Foundry, run npm run foundry:start from the project root to start the needed services. To understand the steps involved in starting foundry services, examine the comments in scripts/foundry/start.sh. This script will:

- start anvil
- start caddy

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
