//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "openzeppelin/contracts/access/Ownable.sol";
import "../interfaces/ILinearStaking.sol";
import "../XRC20.sol";

contract LinearStaking is ILinearStaking, Ownable {
    using SafeERC20 for IERC20;

    address internal _rewardsToken;
    uint256 internal _totalStaked;

    mapping (address => uint256) internal _stakedBalances;
    mapping (address => uint256) internal _userStakedTimestamp;

    constructor(address rewardsToken) Ownable(msg.sender) {
        _rewardsToken = rewardsToken;

    }

    function stake(uint256 amount) external {
        _stakedBalances[msg.sender] += amount;
        if(_stakedBalances[msg.sender] > 0) {
            uint256 accAmount = _calculateRewards();
            _stakedBalances[msg.sender] += accAmount;
            _totalStaked += accAmount;
        }	
        //if user already had rewards, accumulated rewards are added to his balance. And then the timestamp is reset
        _userStakedTimestamp[msg.sender] = block.timestamp; 
        _totalStaked += amount;
        IERC20(_rewardsToken).safeTransferFrom(msg.sender, address(this), amount);

        emit Staked(msg.sender, amount, block.timestamp);
    }

    function unstake(uint256 amount) external {
        uint256 rewards = _calculateRewards();
        _stakedBalances[msg.sender] -= amount;
        _totalStaked -= amount;

        IERC20(_rewardsToken).safeTransfer(msg.sender, amount);
        XRC20(_rewardsToken).mint(msg.sender, rewards); //this contract has admin role in XRC20

        emit Unstaked(msg.sender, amount + rewards);
    }

    function getStakedAmount() external view returns (uint256) {
        return _stakedBalances[msg.sender];
    }

    function getRewards() external view returns (uint256) {
        return _calculateRewards();
    }

    function getUserBalance() external view returns (uint256) {
        return _stakedBalances[msg.sender];
    }

    function getCurrentBalanceAndRewards() external view returns (uint256) {
        return _stakedBalances[msg.sender] + _calculateRewards();
    }

    function _calculateRewards() internal view returns (uint256) {
        uint256 timeStaked = block.timestamp - _userStakedTimestamp[msg.sender];

        uint256 amount = _stakedBalances[msg.sender];
        uint256 rewards = timeStaked * amount; //we earn 1 wei per second;
        
        return rewards;
    }

}