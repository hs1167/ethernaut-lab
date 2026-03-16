// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {Telephone} from "../../src/attacks/Telephone.sol";
import {TelephoneAttack} from "../../src/attacks/TelephoneAttack.sol";

contract TelephoneTest is Test {
    Telephone target;
    TelephoneAttack attackerContract;
    address attacker = makeAddr("attacker");

    function setUp() public {
        target = new Telephone();
        attackerContract = new TelephoneAttack(address(target));
    }

    function test_exploit() public {
        vm.prank(attacker, attacker);
        attackerContract.attack(attacker);

        assertEq(target.owner(), attacker, "attacker should become owner");
    }
}
