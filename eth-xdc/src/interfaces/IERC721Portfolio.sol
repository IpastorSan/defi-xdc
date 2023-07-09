// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

interface IERC721Portfolio {

    event NFTMinted(uint256 number, uint256 currentIndex, address receiver);
    event BaseURIChanged(string newURI);

    /**
    @dev changes BaseURI and set it to the true URI for collection
    @param _newBaseTokenURI new token URI. Format required ipfs://CID/
     */
    function setBaseURI(string memory _newBaseTokenURI) external;

    /**
     * @notice used to mint nfts
     */
    function mintNFT(address to) external; 
    
}