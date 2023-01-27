// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20Upgradeable/ERC20Upgradeable.sol";

contract TestERC20 is ERC20Upgradeable {
    constructor(uint256 initialSupply) ERC20Upgradeable() {
        _mint(msg.sender, initialSupply);
    }
}
