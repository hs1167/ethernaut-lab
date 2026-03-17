// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../../src/attacks/Reentrance.sol";
import "../../src/attacks/ReentranceAttack.sol";

contract ReentranceTest is Test {
    Reentrance reentrance;
    ReentranceAttack attack;

    address victim = address(0x1);
    address attacker = address(0x2);

    function setUp() public {
        reentrance = new Reentrance();

        vm.deal(victim, 10 ether);
        vm.prank(victim);
        reentrance.donate{value: 10 ether}(victim);

        vm.deal(attacker, 1 ether);
        vm.prank(attacker);
        attack = new ReentranceAttack(payable(address(reentrance)));
    }

    function testExploit() public {
        vm.prank(attacker);
        attack.startAttack{value: 0.1 ether}();

        assertEq(address(reentrance).balance, 0);
        assertGt(address(attack).balance, 10 ether);
    }
}
