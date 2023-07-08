// // SPDX-License-Identifier: MIT

// pragma solidity 0.8.19;

// import "forge-std/Test.sol";
// import "./utils/Utils.sol";
// import "../src/portfolio/ERC721Portfolio.sol";
// import "../src/portfolio/ERC6551.sol";
// import "../src/portfolio/ERC6551Registry.sol";
// import "../src/interfaces/ERC6551/IERC6551Account.sol";


// contract ERC6551Test is Test {
    
//     address payable[] internal users;
//     address private deployer;
//     address private alice;
//     address private bob;
//     address private carol;
//     string private base_uri_profile; 
//     string private base_uri_loot;
//     address smartAccount;

//     ERC721Portfolio portfolio;
//     ERC6551Registry registry;
//     ERC6551Account implementation;
//     Utils utils;

//     function setUp() public {
//         utils = new Utils();
//         users = utils.createUsers(4);
//         deployer = users[0];
//         vm.label(deployer, "Deployer");
//         alice = users[1];
//         vm.label(alice, "Alice");
//         bob = users[2];
//         vm.label(bob, "Bob");
//         carol = users[3];
//         vm.label(carol, "Carol");
//         base_uri_profile = "https://ipfs.filebase.io/ipfs/QmZJvWXGVnrxgiY9kHespV2heBz7fqprkbr6zz7zEtZswp/";

//         vm.startPrank(deployer);
//         //Deploy ERC721Profile and attach 1 to every address
//         profile = new ERC721Portfolio(base_uri_profile);
//         profile.mintNFTs(deployer); //ERC721 with token Id 1
//         profile.mintNFTs(alice); //ERC721 with token Id 2
//         profile.mintNFTs(bob); //ERC721 with token Id 3


//         //Deploy ERC6551 Registry
//         registry = new ERC6551Registry();
//         implementation = new ERC6551Account();

//         // Deploy ERC6551 Wallet Account for ERC721 held by Deployer
//         smartAccount = registry.createAccount(address(implementation), 31337, address(profile),
//          1, 1,"");

//          vm.stopPrank();
//     }

//     function testTransferTokenToAccount() external {
//         vm.startPrank(deployer);
//         loot.safeTransferFrom(deployer, smartAccount, 1, 1, "");
//         loot.safeTransferFrom(deployer, smartAccount, 2, 5, "");

//         assertEq(loot.balanceOf(smartAccount, 1), 1);
//         assertEq(loot.balanceOf(smartAccount, 2), 5);
//         assertEq(loot.balanceOf(smartAccount, 3), 0);
//         assertEq(loot.balanceOf(deployer, 1), 0);
//         assertEq(loot.balanceOf(deployer, 2), 0);
//         assertEq(loot.balanceOf(deployer, 3), 2);

//         console.log("Balance of Account of Loot with id 1:",loot.balanceOf(smartAccount, 1));
//         console.log("Balance of Account of Loot with id 2:",loot.balanceOf(smartAccount, 2));
//         console.log("Balance of Deployer of Loot with id 3:",loot.balanceOf(deployer, 3));
//         vm.stopPrank();
//     }

//     function testTransferLootToUserFromAccount() external {
//         vm.startPrank(deployer);
//         loot.safeTransferFrom(deployer, smartAccount, 1, 1, "");
//         assertEq(loot.balanceOf(smartAccount, 1), 1);
//         assertEq(loot.balanceOf(deployer, 1), 0);
//         bytes memory data = abi.encodeWithSignature("safeTransferFrom(address,address,uint256,uint256,bytes)", address(smartAccount), address(alice), 1, 1, "");

//         IERC6551Account(payable(smartAccount)).executeCall(address(loot), 0, data);

//         assertEq(loot.balanceOf(smartAccount, 1), 0);
//         assertEq(loot.balanceOf(alice, 1), 1); //Alice originally doesnt have any Loot with Id 1
//     }

//         function testFailTransferLootToUserFromAccount() external {
//         vm.prank(deployer);
//         loot.safeTransferFrom(deployer, smartAccount, 1, 1, "");
//         assertEq(loot.balanceOf(smartAccount, 1), 1);
//         assertEq(loot.balanceOf(deployer, 1), 0);
//         bytes memory data = abi.encodeWithSignature("safeTransferFrom(address,address,uint256,uint256,bytes)", address(smartAccount), address(alice), 1, 1, "");
//         vm.prank(alice);
//         IERC6551Account(payable(smartAccount)).executeCall(address(loot), 0, data);
//     }

//     function testRevertTransferLootToUserFromAccount() external {
//         vm.prank(deployer);
//         loot.safeTransferFrom(deployer, smartAccount, 1, 1, "");
//         assertEq(loot.balanceOf(smartAccount, 1), 1);
//         assertEq(loot.balanceOf(deployer, 1), 0);
//         bytes memory data = abi.encodeWithSignature("safeTransferFrom(address,address,uint256,uint256,bytes)", address(smartAccount), address(alice), 1, 1, "");
//         vm.prank(alice);
//         vm.expectRevert(bytes("Not token owner"));
//         IERC6551Account(payable(smartAccount)).executeCall(address(loot), 0, data);
//     }

//     function testTransferOwnershipOfProfile() external {
//         vm.prank(deployer);
//         loot.safeTransferFrom(deployer, smartAccount, 1, 1, "");
//         assertEq(loot.balanceOf(smartAccount, 1), 1);
//         assertEq(loot.balanceOf(deployer, 1), 0);
//         //We transfer profile NFT from deployer to carol, should give her access to loot with token id 1
//         vm.prank(deployer);
//         profile.transferFrom(deployer, carol, 1);
//         assertEq(profile.ownerOf(1), carol);
//         //Carol should now be able to transfer loot with token id 1 to alice
//         bytes memory data = abi.encodeWithSignature("safeTransferFrom(address,address,uint256,uint256,bytes)", address(smartAccount), address(alice), 1, 1, "");
//         vm.prank(carol);
//         IERC6551Account(payable(smartAccount)).executeCall(address(loot), 0, data);
//         assertEq(loot.balanceOf(smartAccount, 1), 0);
//         assertEq(loot.balanceOf(alice, 1), 1); //Alice originally doesnt have any Loot with Id 1
//     }

//         function testRevertTransferLootToUserFromPreviousProfileOwner() external {
//         vm.prank(deployer);
//         loot.safeTransferFrom(deployer, smartAccount, 1, 1, "");
//         assertEq(loot.balanceOf(smartAccount, 1), 1);
//         assertEq(loot.balanceOf(deployer, 1), 0);
//         //We transfer profile NFT from deployer to carol, should give her access to loot with token id 1
//         vm.prank(deployer);
//         profile.transferFrom(deployer, carol, 1);
//         assertEq(profile.ownerOf(1), carol);
//         bytes memory data = abi.encodeWithSignature("safeTransferFrom(address,address,uint256,uint256,bytes)", address(smartAccount), address(alice), 1, 1, "");
//         vm.prank(deployer);
//         vm.expectRevert(bytes("Not token owner"));
//         IERC6551Account(payable(smartAccount)).executeCall(address(loot), 0, data);
//     }
// }