// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

interface ILinearStaking {

    error InsufficientStakeAmount();
    error InsufficientAmountToUnstake();
    error UserAlreadyStaked();


    event Staked(address indexed user, uint256 amount, uint256 timestamp);
    event Unstaked(address indexed user, uint256 amount);

    function stake(uint256 amount) external;
    function unstake(uint256 amount) external;
    function getRewards() external view returns (uint256);
    function getCurrentBalanceAndRewards() external view returns (uint256); 
    function getStakedAmount() external view returns (uint256);
}