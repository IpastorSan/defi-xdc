// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

interface IRandomStaking {
    error InsufficientStakeAmount();
    error InsufficientAmountToUnstake();


    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount);
}