# private storage is not secret

## Core idea
In Solidity, `private` restricts access at the language level, not at the chain-observer level.

## Solidity and EVM viewpoint
All storage is visible to anyone who can inspect the chain state. Visibility modifiers only affect what other Solidity contracts can access directly through the type system.

## Exploit intuition
If a contract stores a password, key, or secret in state, the attacker can often read the relevant storage slot directly and replay the value into a public function.

## Example levels
Vault and Privacy.

## Defensive takeaway
Never assume on-chain storage is confidential. If a secret matters, it cannot live in plaintext on-chain.
