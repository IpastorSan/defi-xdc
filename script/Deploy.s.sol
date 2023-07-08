// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "openzeppelin/contracts/access/Ownable.sol";
import "../src/portfolio/ERC721Portfolio.sol";
import "../src/portfolio/ERC6551Registry.sol";
import "../src/portfolio/ERC6551Account.sol";

contract Deploy is Script, Ownable {
    address deployer;
    address alice;
    address bob;
    string base_uri_portfolio; 
    string base_uri_loot;

    function setUp() public {
        deployer = address(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        alice = address(0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
        bob = address(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC);
        base_uri_portfolio = "https://ipfs.filebase.io/ipfs/QmZJvWXGVnrxgiY9kHespV2heBz7fqprkbr6zz7zEtZswp/";
        base_uri_loot = "ipfs://";
    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY_ANVIL_0");
        vm.startBroadcast(deployerPrivateKey);

        //Deploy ERC721portfolio and attach 1 to every address
        ERC721Portfolio portfolio = new ERC721portfolio(base_uri_portfolio);
        portfolio.mintNFTs(deployer); //ERC721 with token Id 1
        portfolio.mintNFTs(alice); //ERC721 with token Id 2
        portfolio.mintNFTs(bob); //ERC721 with token Id 3
        
        //Deploy ERC6551 Registry
        ERC6551Registry registry = new ERC6551Registry();
        ERC6551Account implementation = new ERC6551Account();

        // Deploy ERC6551 Wallet Account for ERC721 held by Deployer
        address smartAccount = registry.createAccount(address(implementation), 31337, address(portfolio),
         1, 1,"");

        vm.stopBroadcast();
    }

}