// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "forge-std/Vm.sol";
import "openzeppelin/contracts/access/Ownable.sol";
import "../src/portfolio/ERC721Portfolio.sol";
import "../src/portfolio/ERC6551Registry.sol";
import "../src/portfolio/ERC6551Account.sol";

contract Deploy is Script, Ownable {
    address deployer;
    string base_uri_portfolio; 

    constructor() Ownable(msg.sender) {
    }

    function setUp() public {
        deployer = vm.envAddress("DEPLOYER_ADDRESS");
        base_uri_portfolio = "https://ipfs.filebase.io/ipfs/QmZJvWXGVnrxgiY9kHespV2heBz7fqprkbr6zz7zEtZswp/";
       
    }

    function run() public {
        
        vm.startBroadcast();

        //Deploy ERC721portfolio and attach 1 to every address
        ERC721Portfolio portfolio = new ERC721Portfolio(base_uri_portfolio);
        portfolio.mintNFT(deployer); //ERC721 with token Id 1
        
        //Deploy ERC6551 Registry
        ERC6551Registry registry = new ERC6551Registry();
        ERC6551Account implementation = new ERC6551Account();

        // Deploy ERC6551 Wallet Account for ERC721 held by Deployer
        //@param implementation: address of the ERC6551Account implementation
        //@param chainId
        //@param ERC721 token contract
        //@param token Id
        //@param salt
        //@param initData
        address smartAccount = registry.createAccount(address(implementation), 50, address(portfolio),
         1, 1,"");

        console.log("ERC721Portfolio address: ", address(portfolio));
        console.log("ERC6551Registry address: ", address(registry));
        console.log("ERC6551Account address: ", address(implementation));
        console.log("ERC6551Wallet address: ", address(smartAccount));

        vm.stopBroadcast();
    }

}