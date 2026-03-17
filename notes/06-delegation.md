# Level 06 — Delegation

The bug is an unsafe `delegatecall` in the fallback path.
Calling the contract with the selector of `pwn()` executes `Delegate.pwn()` in the storage context of `Delegation`.
This overwrites slot 0 and makes the caller the owner.
