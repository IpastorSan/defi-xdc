// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../interfaces/IERC721Portfolio.sol";

contract ERC721Portfolio is IERC721Portfolio, ERC721, Ownable {
    uint256 public index; 
    string public baseTokenURI;

    constructor(string memory baseURI) ERC721("NFTContract", "NFT") Ownable(msg.sender){
        baseTokenURI = baseURI;
         index = 1; //initialized as 1 for gas efficiency
    }

    function _baseURI() internal view override returns (string memory) {
       return baseTokenURI;
    }

    function setBaseURI(string memory newBaseTokenURI) public onlyOwner {
        baseTokenURI = newBaseTokenURI;
        emit BaseURIChanged(newBaseTokenURI);
    }

    function mintNFT(address to) public {
        
        _mint(to, index);

        unchecked {
                index += 1 ;
            }
        emit NFTMinted(1, index - 1, msg.sender);
    }
}