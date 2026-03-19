# forced ether and balance invariants

## Core idea
A contract cannot fully control the ways in which ETH reaches its balance.

## Solidity and EVM viewpoint
Even without a payable function, a contract can receive ETH through mechanisms such as `selfdestruct` (though severely restricted since Dencun/EIP-6780) or by being designated as a block reward destination. The balance can therefore change without any explicit internal logic running.

## Exploit intuition
If a contract implicitly assumes that its balance only changes through approved code paths, an attacker may violate that assumption by forcing ETH into it.

## Example level
Force.

## State Invariant
Do not build critical invariants on the assumption that `address(this).balance` only changes through expected payable entrypoints.
