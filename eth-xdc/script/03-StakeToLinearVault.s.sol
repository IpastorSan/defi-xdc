// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "forge-std/Vm.sol";
import "openzeppelin/contracts/access/Ownable.sol";
import "../src/interfaces/ERC6551/IERC6551Account.sol";
import "../src/LinearRewardsVault.sol";
import "../src/XRC20.sol";

contract Deploy is Script, Ownable {
    address smartAccount;
    address linearRewardsVault;
    address token0;

    constructor() Ownable(msg.sender) {
    }

    function setUp() public {
        smartAccount = vm.envAddress("SMART_ACCOUNT_ADDRESS");
        linearRewardsVault = vm.envAddress("LINEAR_REWARDS_VAULT_ADDRESS");  
        token0 = vm.envAddress("TOKEN0_ADDRESS");
    }

    function run() public {
        
        vm.startBroadcast();

        //Get address of Smart Account owned by Deployer

        //Build tx, encode it and pass it to smart account. If msg.sender == owner of Portfolio NFT, the transaction
        //will be executed. Otherwise, it will be rejected.

        bytes memory data1 = abi.encodeWithSignature("approve(address,uint256)", address(linearRewardsVault), type(uint256).max);

        //@param target Address of the contract to be called
        //@param value Amount of wei to be sent with the transaction
        //@param data Encoded data of the transaction
        IERC6551Account(payable(smartAccount)).executeCall(address(token0), 0, data1);
        
        //We are encoding the deposit function from ERC4626
        bytes memory data2 = abi.encodeWithSignature("deposit(uint256,address)", XRC20(token0).balanceOf(vm.envAddress("DEPLOYER_ADDRESS")), msg.sender);

        IERC6551Account(payable(smartAccount)).executeCall(address(linearRewardsVault), 0, data2);

        vm.stopBroadcast();
    }

}