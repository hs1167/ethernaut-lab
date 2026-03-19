# EVM Exploit Pattern Index

## Authentication Confusion

### tx.origin vs msg.sender
- Example level: Telephone
- Core issue: authorization is based on transaction origin instead of the immediate caller.
- Exploit shape: route the call through an intermediate contract so that `tx.origin` stays unchanged while `msg.sender` changes.
- Defensive principle: authorization should rely on `msg.sender`, not `tx.origin`.

## Dangerous Dispatch Paths

### receive or fallback mutating privileged state
- Example level: Fallback
- Core issue: a payable dispatch path modifies ownership or another privileged variable.
- Exploit shape: satisfy a weak precondition, then send ETH directly to the contract with empty calldata.
- Defensive principle: receiving ETH should not reassign privileged state.

## Delegated Execution

### delegatecall writing into caller storage
- Example level: Delegation
- Core issue: foreign code executes in the storage context of the caller.
- Exploit shape: trigger a delegated function whose storage writes overlap with privileged slots in the caller.
- Defensive principle: never delegatecall into logic you do not fully control, and reason explicitly about storage layout.

## Predictable On-Chain Randomness

### blockhash-based randomness
- Example level: CoinFlip
- Core issue: the contract derives a decision from publicly available chain state.
- Exploit shape: recompute the same value off-chain or in an auxiliary contract and submit the matching guess.
- Defensive principle: block variables are not secure randomness against an adversarial caller.

## Storage Is Public

### private does not mean secret
- Example levels: Vault, Privacy
- Core issue: Solidity visibility does not hide storage from chain observers.
- Exploit shape: read the relevant slot directly and pass the leaked value back into the contract.
- Defensive principle: never store secrets on-chain in plaintext and assume visibility modifiers provide confidentiality.

## Arithmetic Edge Cases

### unchecked underflow and broken assumptions
- Example level: Token
- Core issue: a subtraction is performed in an unchecked context and the guard condition is logically meaningless.
- Exploit shape: trigger underflow from a zero balance and obtain an unexpectedly large balance.
- Defensive principle: avoid unchecked arithmetic unless the surrounding invariant is genuinely proven.

## Forced Ether Delivery

### balance can change without a payable entrypoint
- Example level: Force
- Core issue: the contract assumes it controls the ways in which ETH can reach its balance.
- Exploit shape: deploy a helper contract with ETH and selfdestruct it to the target.
- Defensive principle: do not rely on `address(this).balance` as a protected invariant.

## Push Payment Fragility

### external payment can brick core logic
- Example level: King
- Core issue: the contract must successfully transfer ETH to the current beneficiary before updating state.
- Exploit shape: become the beneficiary with a contract that rejects incoming ETH.
- Defensive principle: prefer pull payments over push payments in critical flows.

## Reentrant Control Flow

### external call before state update
- Example level: Reentrance
- Core issue: the contract transfers value before reducing the recorded balance.
- Exploit shape: reenter from the receive hook until the target is drained.
- Defensive principle: checks-effects-interactions or explicit reentrancy guards.

## Externalized Truth

### untrusted external contract used as an oracle
- Example level: Elevator
- Core issue: a contract trusts an external caller to report a condition consistently.
- Exploit shape: return one value on the first call and another value on the second call in the same transaction.
- Defensive principle: avoid using attacker-controlled contracts as authoritative sources of truth.

## Repeated External Reads

### same external question asked twice
- Example level: Shop
- Core issue: a contract assumes the same external call will return a stable answer twice.
- Exploit shape: let the second answer depend on state changed between the two reads.
- Defensive principle: cache external results or avoid attacker-controlled pricing oracles.
