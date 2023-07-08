// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

interface IERC721Portfolio {

    error CallerIsAnotherContract();
    error NotEnoughNFTsLeft();
    error IncorrectAmountOfEther();
    error CantHoldMoreThanOne();

    event NFTMinted(uint256 number, uint256 currentIndex, address receiver);
    event BaseURIChanged(string newURI);

    /**
    @dev changes BaseURI and set it to the true URI for collection
    @param _newBaseTokenURI new token URI. Format required ipfs://CID/
     */
    function reveal(string memory _newBaseTokenURI) external;

    /**
     * @notice used to mint nfts
     */
    function mintNFTs(address to) external payable; 
    
}