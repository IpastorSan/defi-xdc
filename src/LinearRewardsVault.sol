// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import "openzeppelin/contracts/interfaces/IERC20.sol";
import "openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./interfaces/ILinearStaking.sol";


contract LinearRewardsVault is ERC4626 {

    ILinearStaking internal _linearStaking;
    IERC20 private immutable _asset;

    /**
     * @dev Initializes the contract
     * @param name_ The name of the token.
     * @param symbol_ The symbol of the token.
     * @param asset_ The address of the ERC20 asset.
     */
    constructor(string memory name_, 
                string memory symbol_, 
                address asset_,
                address linearStaking) 
        ERC20(name_, symbol_) ERC4626(IERC20(asset_)) {
        _linearStaking = ILinearStaking(linearStaking);
        _asset = IERC20(asset_);
    }

    /** 
     * @dev Returns the total amount of assets in this contract and the reward pool.
     * @return The total assets.
     */
    function totalAssets() public view override returns (uint256) {
        return _asset.balanceOf(address(this)) + _linearStaking.getCurrentBalanceAndRewards();
    }

    function _deposit(address caller, address receiver, uint256 assets, uint256 shares) internal override {
        // If _asset is ERC777, `transferFrom` can trigger a reentrancy BEFORE the transfer happens through the
        // `tokensToSend` hook. On the other hand, the `tokenReceived` hook, that is triggered after the transfer,
        // calls the vault, which is assumed not malicious.
        //
        // Conclusion: we need to do the transfer before we mint so that any reentrancy would happen before the
        // assets are transferred and before the shares are minted, which is a valid state.
        // slither-disable-next-line reentrancy-no-eth
        SafeERC20.safeTransferFrom(_asset, caller, address(this), assets);

        //We call the stake function of the LinearStaking contract
        _linearStaking.stake(assets);

        _mint(receiver, shares);

        emit Deposit(caller, receiver, assets, shares);
    }

    /**
     * @dev Withdraw/redeem common workflow.
     */
    function _withdraw(
        address caller,
        address receiver,
        address owner,
        uint256 assets,
        uint256 shares
    ) internal override {
        if (caller != owner) {
            _spendAllowance(owner, caller, shares);
        }

        // If _asset is ERC777, `transfer` can trigger a reentrancy AFTER the transfer happens through the
        // `tokensReceived` hook. On the other hand, the `tokensToSend` hook, that is triggered before the transfer,
        // calls the vault, which is assumed not malicious.
        //
        // Conclusion: we need to do the transfer after the burn so that any reentrancy would happen after the
        // shares are burned and after the assets are transferred, which is a valid state.
        _burn(owner, shares);

        _linearStaking.unstake(assets);

        SafeERC20.safeTransfer(_asset, receiver, assets);

        emit Withdraw(caller, receiver, owner, assets, shares);
    }

    

}

