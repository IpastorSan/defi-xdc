// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

import "forge-std/Script.sol";
import "openzeppelin/contracts/access/Ownable.sol";
import "v3-core/contracts/UniswapV3Pool.sol";
import "v3-core/contracts/UniswapV3Factory.sol";
import "v3-core/contracts/UniswapV3PoolDeployer.sol";
import "v3-core/contracts/libraries/SqrtPriceMath.sol";
import "../src/XRC20.sol";

contract Deploy is Script, Ownable {
    uint24 tickSpacing;
    uint160 currentPrice;
    XRC20 token0;
    XRC20 token1;

    function setUp() public {
        fee = 500; //500, 3000, or 10000
        vm.startBroadcast();
        token0 = new XRC20("token0", "T0");
        token1 = new XRC20("token1", "T1");

        token0.mint(address(this), 100 ether);
        token1.mint(address(this), 1000 ether);
        vm.stopBroadcast();
        currentPrice = 250541448375047931186413801569; //use calculate-sqrtPriceX96 script to calculate the price ratio
    }

    function run() public {
        vm.startBroadcast();

        UniswapV3Factory factory = new UniswapV3Factory();
        UniswapV3Pool pool = UniswapV3Pool(factory.createPool(address(token0), address(token1), tickSpacing));
        pool.initialize(currentPrice);

        vm.stopBroadcast();

    }

}