// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {King} from "../../src/attacks/King.sol";
import {KingAttack} from "../../src/attacks/KingAttack.sol";

contract KingChallenger {
    function attack(address payable target) external payable {
        (bool success, ) = target.call{value: msg.value}("");
        require(success, "call failed");
    }
}

contract KingTest is Test {
    King target;

    receive() external payable {}

    function setUp() public {
        vm.deal(address(this), 10 ether);
        target = new King{value: 1 ether}();
    }

    function test_exploit() public {
        KingAttack helper = new KingAttack{value: 2 ether}(payable(address(target)));
        KingChallenger challenger = new KingChallenger();

        assertEq(target.king(), address(helper));
        assertEq(target.prize(), 2 ether);

        vm.expectRevert();
        challenger.attack{value: 3 ether}(payable(address(target)));

        assertEq(target.king(), address(helper));
        assertEq(target.prize(), 2 ether);
    }
}
