// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "openzeppelin/contracts/access/Ownable2Step.sol";
import "openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import "openzeppelin/contracts/interfaces/IERC20.sol";
import "openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";


contract XSwapVault is ERC4626, Ownable2Step {

    /**
     * @dev Initializes the contract
     * @param name_ The name of the token.
     * @param symbol_ The symbol of the token.
     * @param asset_ The address of the ERC20 asset.
     */
    constructor(string memory name_, 
                string memory symbol_, 
                address asset_) ERC20(name_, symbol_) ERC4626(IERC20(asset_)){
    
    }

    /** 
     * @dev Returns the total amount of assets in this contract and the reward pool.
     * @return The total assets.
     */
    function totalAssets() public view override returns (uint256) {
        return _asset.balanceOf(address(this)) + _rewardPool.claimableBalance(address(this));
    }

    /**
     * @dev Redeem shares for the owner.
     * @param receiver The address of the receiver.
     * @param owner The address of the owner.
     * @return The amount of redeemed assets.
     */
    function redeem(
        uint256,
        address receiver,
        address owner
    ) public override returns (uint256) {
        (uint256 assets,) = _dequeueAndWithdraw(receiver, owner);
        return assets;
    }

    /**
     * @dev Withdraw assets for the owner.
     * @param receiver The address of the receiver.
     * @param owner The address of the owner.
     * @return The amount of withdrawn shares.
     */
    function withdraw(
        uint256,
        address receiver,
        address owner
    ) public override returns (uint256) {
        (, uint256 shares) = _dequeueAndWithdraw(receiver, owner);
        return shares;
    }

    /**
     * @dev Process a withdrawal.
     * @param caller The address of the caller.
     * @param receiver The address of the receiver.
     * @param owner The address of the owner.
     * @param assets The amount of assets to withdraw.
     * @param shares The amount of shares to withdraw.
     */
    function _withdraw(
        address caller,
        address receiver,
        address owner,
        uint256 assets,
        uint256 shares
    ) internal override {
        // _rewardPool.claim();
        super._withdraw(caller, receiver, owner, assets, shares);
    }

    function _deposit(
        address caller,
        address receiver,
        uint256 assets,
        uint256 shares
    ) internal override {
        // If _asset is ERC777, `transferFrom` can trigger a reenterancy BEFORE the transfer happens through the
        // `tokensToSend` hook. On the other hand, the `tokenReceived` hook, that is triggered after the transfer,
        // calls the vault, which is assumed not malicious.
        //
        // Conclusion: we need to do the transfer before we mint so that any reentrancy would happen before the
        // assets are transferred and before the shares are minted, which is a valid state.
        // slither-disable-next-line reentrancy-no-eth
        SafeERC20.safeTransferFrom(_asset, receiver, address(this), assets);
        _mint(receiver, shares);

        emit Deposit(caller, receiver, assets, shares);
    }

}

