// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

import "forge-std/Script.sol";
import "openzeppelin/contracts/access/Ownable.sol";
import "v3-core/contracts/UniswapV3Pool.sol";
import "v3-core/contracts/UniswapV3Factory.sol";
import "v3-core/contracts/UniswapV3PoolDeployer.sol";

contract Deploy is Script, Ownable {

    constructor() {

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