# delegatecall and storage context

## Core idea
`delegatecall` executes code from another contract, but preserves the storage, address, and balance context of the caller.

## Solidity and EVM viewpoint
The delegated code is foreign, but the storage writes are local. This is what makes `delegatecall` powerful for proxies and dangerous for security.

## Exploit intuition
If the delegated contract exposes a function that writes to slot 0, and slot 0 in the caller stores `owner`, then the delegated call can overwrite the caller's ownership.

## Example level
Delegation.

## Defensive takeaway
`delegatecall` must only be used with logic you fully control and with an explicitly reasoned storage layout.
