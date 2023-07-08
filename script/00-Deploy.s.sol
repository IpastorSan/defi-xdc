// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "../src/UniswapV3/core/UniswapV3Pool.sol";
import "../src/UniswapV3/core/UniswapV3Factory.sol";
import "../src/UniswapV3/core/UniswapV3PoolDeployer.sol";

contract Deploy is Script, Ownable {

    constructor() Ownable(msg.sender) {

    }

    function setUp() public {
        UniswapV3Factory = new UniswapV3Factory();
        UniswapV3PoolDeployer = new UniswapV3PoolDeployer();
    }

    function run() {
        vm.startBroadcast();

    }
}