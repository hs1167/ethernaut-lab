// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {CoinFlip} from "../../src/attacks/CoinFlip.sol";
import {CoinFlipAttack} from "../../src/attacks/CoinFlipAttack.sol";

contract CoinFlipTest is Test {
    CoinFlip target;
    CoinFlipAttack attackerContract;

    function setUp() public {
        target = new CoinFlip();
        attackerContract = new CoinFlipAttack(address(target));
    }

    function test_consecutiveWins() public {
        for (uint256 i = 0; i < 10; i++) {
            vm.roll(block.number + 1);
            attackerContract.attack();
        }

        assertEq(target.consecutiveWins(), 10, "should reach 10 consecutive wins");
    }
}
