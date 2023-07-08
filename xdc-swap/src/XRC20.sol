//SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

import "openzeppelin/contracts/token/ERC20/ERC20.sol";
import "openzeppelin/contracts/access/AccessControl.sol";

contract XRC20 is ERC20, AccessControl {

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);

    }

    modifier onlyRole(bytes32 role) {
        require(hasRole(role, msg.sender), "XRC20: must have admin role");
        _;
    }

    function mint(address to, uint256 amount) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _mint(to, amount);
    }
}