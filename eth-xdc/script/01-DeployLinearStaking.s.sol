// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "forge-std/Vm.sol";
import "openzeppelin/contracts/access/Ownable.sol";
import "../src/interfaces/IUniswapV3Factory.sol";
import "../src/defi/LinearStaking.sol";
import "../src/LinearRewardsVault.sol";
import "../src/XRC20.sol";

contract Deploy is Script, Ownable {
    address token0Address; 
    
    constructor() Ownable(msg.sender) { }
    function setUp() public {
        token0Address = vm.envAddress("TOKEN0_ADDRESS");
        XRC20 token0 = XRC20(token0Address);
    }

    function run() public {
        
        vm.startBroadcast();
        
        LinearStaking linearStaking = new LinearStaking(token0Address);
        LinearRewardsVault vault = new LinearRewardsVault("stToken0", "sT0", token0Address, address(linearStaking));
        
        console.log("LinearStaking address: ", address(linearStaking));
        console.log("LinearRewardsVault address: ", address(vault));
        
        vm.stopBroadcast();
    }

}