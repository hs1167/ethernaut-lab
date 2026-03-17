# Level 05 — Token

The bug is an underflow in `transfer`.
A sender with zero balance can transfer a positive amount because the checked expression is placed inside `unchecked`.
This wraps the sender balance to a huge value instead of reverting.
