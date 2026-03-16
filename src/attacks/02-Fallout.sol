// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Fallout {
    mapping(address => uint256) allocations;
    address payable public owner; // Changement : on ajoute "payable"

    function Fal1out() public payable {
        owner = payable(msg.sender); // Changement : on "cast" en payable
        allocations[owner] = msg.value;
    }

    function allocate() public payable {
        allocations[msg.sender] += msg.value;
    }

    function sendAllocation(address payable allocator) public {
        // Changement : "payable"
        require(allocations[allocator] > 0);
        allocator.transfer(allocations[allocator]);
    }

    function collectAllocations() public {
        require(msg.sender == owner);
        owner.transfer(address(this).balance); // Maintenant autorisé
    }

    function allocatorBalance(address allocator) public view returns (uint256) {
        return allocations[allocator];
    }
}
