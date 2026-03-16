// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CoinFlip {
    uint256 public consecutiveWins;
    uint256 private lastHash;

    uint256 private constant FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function flip(bool _guess) public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert("same block hash");
        }

        lastHash = blockValue;
        bool side = (blockValue / FACTOR) == 1;

        if (side == _guess) {
            consecutiveWins++;
            return true;
        } else {
            consecutiveWins = 0;
            return false;
        }
    }
}
