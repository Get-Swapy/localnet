// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../../contracts/ERC20.sol";

contract MyScript is Script {
    function run() external {
        // the private key of the deployer is the first private key printed by running anvil
        uint256 deployerPrivateKey = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
        // we use that key to broadcast all following transactions
        vm.startBroadcast(deployerPrivateKey);

        // this creates the contract. it will have the same address every time if we use a 
        // new instance of anvil for every deployment.

        new MockERC20();

        vm.stopBroadcast();
    }
}
