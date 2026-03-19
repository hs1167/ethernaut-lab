# Level 10 — Reentrance

The bug is an external call before the balance update.
The attacker reenters `withdraw` from the receive hook and drains the contract before the bookkeeping is reduced.
