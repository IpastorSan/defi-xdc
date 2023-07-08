//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "openzeppelin/contracts/access/Ownable.sol";
import "../interfaces/IRandomStaking.sol";

contract RandomStaking is IRandomStaking, Ownable {
    using SafeERC20 for IERC20;

    address internal _rewardsToken;
    uint256 internal _totalStaked;
    uint256 internal _minStakeAmount;

    mapping (address => uint256) internal _stakedBalances;

    constructor(address rewardsToken) Ownable(msg.sender) {
        _rewardsToken = rewardsToken;
    }

    function stake(uint256 amount) external {
        if(amount < _minStakeAmount) revert InsufficientStakeAmount();
        _stakedBalances[msg.sender] += amount;
        _totalStaked += amount;
        IERC20(_rewardsToken).safeTransferFrom(msg.sender, address(this), amount);

        emit Staked(msg.sender, amount);
    }

    function unstake(uint256 amount) external {
        if(amount > _stakedBalances[msg.sender]) revert InsufficientAmountToUnstake();
        _stakedBalances[msg.sender] -= amount;
        uint256 rewards = _calculateRewards(msg.sender, amount);
        _totalStaked -= amount;
        IERC20(_rewardsToken).safeTransfer(msg.sender, amount + rewards);

        emit Unstaked(msg.sender, amount + rewards);
    }

    function unstakeAll() external {
        uint256 amount = _stakedBalances[msg.sender];
        uint256 rewards = _calculateRewards(msg.sender, amount);
        _stakedBalances[msg.sender] = 0;
        _totalStaked -= amount;
        IERC20(_rewardsToken).safeTransfer(msg.sender, amount + rewards);

        emit Unstaked(msg.sender, amount + rewards);
    }

    function getStakedAmount(address user) external view returns (uint256) {
        return _stakedBalances[user];
    }

    function getMinStakeAmount() external view returns (uint256) {
        return _minStakeAmount;
    }

    function _calculateRewards(address user, uint256 amount) internal returns (uint256) {
        uint256 seed = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, user)));

        uint256 pseudoRandomPercentage = (seed % (100 - 1)) + 1;

        uint256 pseudoRandomNumber = (amount * pseudoRandomPercentage) / 100;

        return pseudoRandomNumber;
    }

}