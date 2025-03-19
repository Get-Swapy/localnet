# Localnet for Swapy

Swapy Localnet provides a development environment for testing and developing with both EVM-compatible chains and the Internet Computer Protocol (ICP).

## Prerequisites

Ensure the following are installed on your system:

- [Node.js](https://nodejs.org/en/) `>= 22`
- [Foundry](https://github.com/foundry-rs/foundry)
- [Caddy](https://caddyserver.com/docs/install#install)
- [DFX](https://internetcomputer.org/docs/current/developer-docs/build/install-upgrade-remove) `>= 0.25.0`

## Installation

```sh
git clone https://github.com/Get-Swapy/localnet.git
cd localnet
git submodule update --init --recursive
```

## Getting started

### Start the Local ICP Environment

This project is a complement for local develoment of Swapy. Then we assume that you have running a icp replica. If don't have it, you can use the following command:

```bash
dfx start --background
```

### Start the Local Ethereum Environment

```bash
npm run foundry:start
```

### Deploy Contracts

```bash
npm run deploy
```

## Working with ERC-20 Tokens

Foundry uses by default following private key:

0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

This account receive `1,000,000 ERC20` tokens once `npm run deploy` is completed.

You can use the following command to check the balance of the account:

```bash
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "balanceOf(address)(uint256)" 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 --rpc-url http://127.0.0.1:8545
```

To perform transfers using ERC-20 tokens, you can use the following script:

```bash
cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 "transfer(address,uint256)" ADDRES_TO_TRANSFER AMOUN_TO_TRANSFER --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

## Working with ICRC Tokens

### Basic Transfer Format

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

### Example Transfer

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
