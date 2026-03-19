# tx.origin vs msg.sender

## Core idea
`tx.origin` is the externally owned account that initiated the full transaction, while `msg.sender` is the immediate caller in the current call frame.

## Solidity and EVM viewpoint
Authorization based on `tx.origin` leaks trust across intermediate contracts. Any malicious contract can preserve the same transaction origin while changing the local caller seen by the victim contract.

## Exploit intuition
If a contract grants privileges based on `tx.origin`, the attacker only needs to route the call through an auxiliary contract. The local `msg.sender` becomes the helper contract, while `tx.origin` remains the original user.

## Example level
Telephone.

## Defensive takeaway
Authorization should almost always be expressed in terms of `msg.sender`, not `tx.origin`.
