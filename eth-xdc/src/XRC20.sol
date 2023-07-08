//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "openzeppelin/contracts/token/ERC20/ERC20.sol";
import "openzeppelin/contracts/access/AccessControl.sol";

contract XRC20 is ERC20, AccessControl {
    error InvalidLength();

    constructor(address[] memory accounts, uint256[] memory amounts) ERC20("RandomToken", "RTK") {
        if (accounts.length != amounts.length) revert InvalidLength();

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);

        for (uint256 i = 0; i < accounts.length; i++) {
            _mint(accounts[i], amounts[i]);
        }
    }

    function mint(address to, uint256 amount) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _mint(to, amount);
    }
}