# Shamba Smart Contracts

## Installation

```
# via npm
$ npm install @shambadynamic/contracts --save
# via pnpm
$ pnpm add @shambadynamic/contracts
```

##### Directory Structure

```
@shambadynamic/contracts
└── contracts  # Shamba Ecological Oracle Solidity Contracts
	├── ShambaFireConsumer.sol 
        ├── ShambaGeoConsumer.sol
        └── utils  # Utility Contracts
              ├─ ShambaChainSelector.sol        # Shamba Chain Selector Utility
	      └─ ShambaWhitelistAccounting.sol  # Shamba Whitelist Accounting Utility
```

##### Usage

The solidity smart contracts themselves can be imported via the `contracts` directory of `@shambadynamic/contracts`:

###### To import `ShambaGeoConsumer` contract:

```solidity
import "@shambadynamic/contracts/contracts/ShambaGeoConsumer.sol";
```

###### To import `ShambaFireConsumer` contract:

```solidity
import "@shambadynamic/contracts/contracts/ShambaFireConsumer.sol";
```

## Local Development

```
# Clone Shamba Smart-Contract-Kit repository
$ git clone https://github.com/shambadynamic/shamba-smartcontractkit
$ cd contracts/
```
