# Level 07 — Force

The contract has no payable entrypoint, but ETH can still be forced into it with `selfdestruct`.
The exploit deploys a helper contract with ETH and selfdestructs it to the target.
