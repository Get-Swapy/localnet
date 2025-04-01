# Localnet for Swapy

Swapy Localnet provides a comprehensive development environment for testing and developing with both EVM-compatible chains and the Internet Computer Protocol (ICP). This environment allows you to run local instances of both blockchain networks simultaneously for development and testing purposes.

## Overview

Swapy is a cross-chain platform that enables seamless interaction between EVM-based blockchains (like Ethereum) and the Internet Computer Protocol. This localnet setup creates a controlled environment where developers can:

- Test smart contracts on a local Ethereum node (via Foundry's Anvil)
- Deploy and interact with Internet Computer canisters
- Develop and test cross-chain functionality
- Simulate token transfers and interactions between different blockchain environments

## Prerequisites

Ensure the following are installed on your system:

- [Node.js](https://nodejs.org/en/) `>= 22` - JavaScript runtime environment
- [Foundry](https://github.com/foundry-rs/foundry) - Development toolkit for Ethereum applications
- [Caddy](https://caddyserver.com/docs/install#install) - Web server that provides HTTPS support
- [DFX](https://internetcomputer.org/docs/current/developer-docs/build/install-upgrade-remove) `>= 0.25.0` - Command-line interface for the Internet Computer

## Installation

```sh
git clone https://github.com/Get-Swapy/localnet.git
cd localnet
git submodule update --init --recursive
npm install
```

This will clone the repository, initialize the submodules (including OpenZeppelin contracts), and install the necessary Node.js dependencies.

## Getting Started

### Start the Local ICP Environment

This project is a complement for local development of Swapy. You can start the ICP replica with one of the following commands:

**Command:**

```bash
npm run ic:start
```

This starts the Internet Computer replica in the background.

If you want to start with a clean state (removing previous state):

**Command:**

```bash
npm run ic:start:clean
```

To stop the ICP replica:

**Command:**

```bash
npm run ic:stop
```

**Note:** Make sure your dfx version is 0.25.0 or higher as specified in the prerequisites. You can check your current version with `dfx --version`.

### Start the Local Ethereum Environment

This command starts both Anvil (Ethereum node) and Caddy server (for HTTPS support):

**Command:**

```bash
npm run foundry:start
```

For debugging purposes with more verbose logging, you can use:

**Command:**

```bash
npm run foundry:start:debug
```

To stop the Ethereum environment:

**Command:**

```bash
npm run foundry:stop
```

**Note:** The Ethereum node runs on port 8545, and Caddy provides HTTPS access on port 8546. Make sure these ports are available on your system before starting the services.

### Deploy Contracts

Deploy ERC-20 contracts to the local Ethereum environment:

**Command:**

```bash
npm run foundry:deploy
```

This deploys a MockERC20 token with the following properties:

- Name: "ERC20 Coin"
- Symbol: "ERC20"
- Decimals: 6
- Initial supply: 1,000,000 tokens minted to the deployer account

Deploy Internet Computer canisters:

**Command:**

```bash
npm run ic:deploy
```

This command deploys the following canisters:

- Internet Identity (canister ID: rdmx6-jaaaa-aaaaa-aaadq-cai)
- ICP Ledger (canister ID: ryjl3-tyaaa-aaaaa-aaaba-cai)
- EVM RPC (canister ID: 7hfb6-caaaa-aaaar-qadga-cai)

The deployment also creates two identities if they don't exist:

- swapy-minter: Used as the minting account for the ICP ledger
- swapy-default-account: Receives an initial balance of 10,000 ICP tokens

### Clean Up

To clean Foundry artifacts:

**Command:**

```bash
npm run foundry:clean
```

To clean all artifacts (including .dfx):

**Command:**

```bash
npm run clean
```

## Working with ERC-20 Tokens

Foundry uses by default the following private key for the first account:

```
0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

This account receives `1,000,000 ERC20` tokens once `npm run foundry:deploy` is completed. The corresponding address for this private key is:

```
0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
```

The deployed ERC20 token contract address will typically be `0x5FbDB2315678afecb367f032d93F642f64180aa3` when using a fresh Anvil instance.

### Checking ERC-20 Token Balances

**Command:**

```bash
npm run erc20:balance contract_address=CONTRACT_ADDRESS address=ACCOUNT_ADDRESS
```

**Example:**

```bash
npm run erc20:balance contract_address=0x5FbDB2315678afecb367f032d93F642f64180aa3 address=0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
```

### Transferring ERC-20 Tokens

**Command:**

```bash
npm run erc20:transfer contract_address=CONTRACT_ADDRESS address=RECIPIENT_ADDRESS amount=AMOUNT_TO_TRANSFER
```

**Example:**

```bash
npm run erc20:transfer contract_address=0x5FbDB2315678afecb367f032d93F642f64180aa3 address=0x70997970C51812dc3A010C7d01b50e0d17dc79C8 amount=100000000
```

### Transferring ETH for Gas Fees

To perform transactions on the network, your account needs to have ETH for gas fees.

**Command:**

```bash
npm run eth:transfer address=RECIPIENT_ADDRESS amount=AMOUNT_TO_TRANSFER
```

**Example:**

```bash
npm run eth:transfer address=0x70997970C51812dc3A010C7d01b50e0d17dc79C8 amount=1000000000000000000
```

### Checking ETH Balances

To check the ETH balance of an account:

**Command:**

```bash
npm run eth:balance address=ACCOUNT_ADDRESS
```

**Example:**

```bash
npm run eth:balance address=0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
```

## Working with ICRC Tokens

ICRC tokens are the token standard used on the Internet Computer Protocol. The most common example is ICP (Internet Computer Protocol) token itself.

### Understanding Subaccounts in ICRC

In the Internet Computer, accounts are identified by a combination of:

- A principal ID (the main identifier for an entity on the IC)
- A subaccount (an optional 32-byte array that allows a principal to have multiple accounts)

This localnet setup provides a convenient way to work with subaccounts by allowing you to specify a UUID, which is then converted to the appropriate subaccount format.

### Checking ICRC Token Balances

**Command:**

```bash
npm run icrc:balance canister_name=CANISTER_NAME canister_id=CANISTER_ID [user_id=USER_ID]
```

**Parameters:**

- `canister_name`: The name of the canister in dfx.json (e.g., icp_ledger)
- `canister_id`: The principal ID of the canister or user whose balance you want to check
- `user_id`: (Optional) A UUID that will be converted to a subaccount

**Example:**

```bash
npm run icrc:balance canister_name=icp_ledger canister_id=bd3sg-teaaa-aaaaa-qaaba-cai user_id=79ae33a4-ab4d-4e86-ba95-37e7245770b1
```

**Note:**

- `user_id` is optional and should be a UUID (e.g., 123e4567-e89b-12d3-a456-426614174000). If not provided, subaccount will be null.
- The script automatically converts the UUID to the appropriate subaccount format required by the ICRC-1 standard.
- UUID to subaccount conversion: The UUID is converted to a 32-byte array where the first 16 bytes are zeros and the last 16 bytes contain the UUID bytes.

### Transferring ICRC Tokens

**Command:**

```bash
npm run icrc:transfer canister_name=CANISTER_NAME canister_id=CANISTER_ID [user_id=USER_ID] amount=AMOUNT
```

**Parameters:**

- `canister_name`: The name of the canister in dfx.json (e.g., icp_ledger)
- `canister_id`: The principal ID of the recipient
- `user_id`: (Optional) A UUID that will be converted to a subaccount for the recipient
- `amount`: The amount of tokens to transfer (in atomic units, e.g., E8s for ICP)

**Example:**

```bash
npm run icrc:transfer canister_name=icp_ledger canister_id=bd3sg-teaaa-aaaaa-qaaba-cai user_id=123e4567-e89b-12d3-a456-426614174000 amount=1000000
```

**Note:**

- `user_id` is optional and should be a UUID (e.g., 123e4567-e89b-12d3-a456-426614174000). If not provided, subaccount will be null.
- The transfer is executed from the currently selected dfx identity. You can check your current identity with `dfx identity whoami` and switch identities with `dfx identity use <identity-name>`.
- For ICP, 1 ICP = 100,000,000 E8s (atomic units). Always specify amounts in E8s (the smallest unit) when using these commands.

## Architecture

The Swapy Localnet consists of two main components:

1. **EVM Environment**:

   - Anvil: A local Ethereum node for development and testing
   - Caddy: A web server that provides HTTPS access to the Anvil node
   - ERC-20 Token: A mock ERC-20 token deployed for testing purposes

2. **Internet Computer Environment**:
   - ICP Replica: A local instance of the Internet Computer Protocol
   - Internet Identity: A canister for authentication
   - ICP Ledger: A canister that simulates the ICP token ledger
   - EVM RPC: A canister that provides RPC access to EVM chains

## Troubleshooting

### Common Issues

1. **Port Conflicts**:

   - If you encounter errors about ports being in use, ensure no other services are running on ports 8545 and 8546.
   - You can check for processes using these ports with: `lsof -i :8545` or `lsof -i :8546`

2. **DFX Version Issues**:

   - If you encounter compatibility issues with dfx, ensure you're using version 0.25.0 or higher.
   - You can update dfx with: `dfx upgrade`

3. **Anvil Connection Issues**:

   - If you can't connect to Anvil, ensure the service is running with: `ps aux | grep anvil`
   - Try restarting the service with: `npm run foundry:stop` followed by `npm run foundry:start`

4. **Missing Dependencies**:
   - If you encounter errors about missing dependencies, ensure you've run `npm install` and that all prerequisites are installed.

### Resetting the Environment

If you encounter persistent issues, you can reset the entire environment with:

```bash
npm run foundry:stop
npm run ic:stop
npm run clean
```

Then restart the services as needed.
