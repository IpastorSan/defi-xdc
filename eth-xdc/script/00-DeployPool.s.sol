// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "openzeppelin/contracts/access/Ownable.sol";
import "../src/interfaces/IUniswapV3Factory.sol";
import "../src/interfaces/IUniswapV3Pool.sol";
import "../src/XRC20.sol";

contract Deploy is Script, Ownable {
    address uniswapFactory; 
    uint24 fee;
    XRC20 token0;
    XRC20 token1;
    uint160 currentPrice;

    constructor() Ownable(msg.sender) { }
    function setUp() public {
        uniswapFactory = 0x557f543ad8c7f8648B8Cadab1144cC8E9998CD6F;
        fee = 500; //500, 3000, or 10000
        token0 = new XRC20("token0", "T0");
        token1 = new XRC20("token1", "T1");

        token0.mint(address(this), 100 ether);
        token1.mint(address(this), 1000 ether);
        currentPrice = 250541448375047931186413801569;
    }

    function run() public {
        
        vm.startBroadcast();

        IUniswapV3Factory factory = IUniswapV3Factory(uniswapFactory);
        IUniswapV3Pool pool = IUniswapV3Pool(factory.createPool(address(token0), address(token1), fee));
        pool.initialize(currentPrice);

        vm.stopBroadcast();
    }

}