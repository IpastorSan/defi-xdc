// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "openzeppelin/contracts/access/Ownable.sol";
import "../src/defi/UniswapV3/core/UniswapV3Pool.sol";
import "../src/defi/UniswapV3/core/UniswapV3Factory.sol";
import "../src/defi/UniswapV3/core/UniswapV3PoolDeployer.sol";

contract Deploy is Script, Ownable {

    constructor() Ownable(msg.sender) {

    }

    function setUp() public {

    }

    function run() public {
        vm.startBroadcast();

        UniswapV3Factory factory = new UniswapV3Factory();
        UniswapV3PoolDeployer deployer = new UniswapV3PoolDeployer();

        vm.stopBroadcast();

    }
}