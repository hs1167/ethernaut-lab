// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract King {
    address payable public king;
    uint256 public prize;
    address payable public owner;

    constructor() payable {
        owner = payable(msg.sender);
        king = payable(msg.sender);
        prize = msg.value;
    }

    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);
        (bool sent, ) = king.call{value: msg.value}("");
        require(sent);
        king = payable(msg.sender);
        prize = msg.value;
    }
}
