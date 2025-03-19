#!/bin/bash

# deploy the contract passing the chain_fusion canisters evm address to receive the fees and create a couple of new jobs
forge script scripts/foundry/erc20.s.sol:MyScript --fork-url http://localhost:8545 --broadcast --sig "run()"
