// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

contract SanityTest is Test {
    function test_sanity() public {
        assertEq(uint256(1), uint256(1));
    }
}
