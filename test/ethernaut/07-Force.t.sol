// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {Force} from "../../src/attacks/Force.sol";
import {ForceAttack} from "../../src/attacks/ForceAttack.sol";

contract ForceTest is Test {
    Force target;

    function setUp() public {
        target = new Force();
    }

    function test_exploit() public {
        vm.deal(address(this), 1 ether);

        ForceAttack helper = new ForceAttack{value: 1 wei}();
        helper.attack(payable(address(target)));

        assertEq(address(target).balance, 1 wei);
    }
}
