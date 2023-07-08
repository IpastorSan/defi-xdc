// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../interfaces/IERC721Portfolio.sol";

contract ERC721Portfolio is IERC721Portfolio, ERC721, Ownable {
    uint256 public index = 1;
    string public baseTokenURI;

    constructor(string memory baseURI) ERC721("NFTContract", "NFT") {
        baseTokenURI = baseURI;
    }

    function _baseURI() internal view override returns (string memory) {
       return baseTokenURI;
    }

    function reveal(string memory newBaseTokenURI) public onlyOwner {
        baseTokenURI = newBaseTokenURI;
        emit BaseURIChanged(newBaseTokenURI);
    }

    function mintNFTs(address to) public payable {
        if(balanceOf(to) > 0) revert CantHoldMoreThanOne();
        
        _mint(to, index);
        unchecked {
                index += 1 ;
            }
        emit NFTMinted(1, index - 1, msg.sender);
    }
}