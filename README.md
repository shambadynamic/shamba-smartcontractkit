# Shamba Smart Contracts

## Prerequisites

Install [@chainlink/contracts](https://www.npmjs.com/package/@chainlink/contracts) package:

```
# via npm
$ npm install @chainlink/contracts --save
# via pnpm
$ pnpm add @chainlink/contracts
```

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
        └── utils  # Utility Contracts/Libraries
              ├─ libraries 
              |        └─ NetworkConfig.sol           # Network Config Utility Library
	      └─ ShambaWhitelistAccounting.sol        # Shamba Whitelist Accounting Utility Contract
```

##### Usage

The solidity smart contracts themselves can be imported via the `contracts` directory of `@shambadynamic/contracts`:

###### To import `ShambaGeoConsumer` contract:

```solidity
import {ShambaGeoConsumer} from "@shambadynamic/contracts/contracts/ShambaGeoConsumer.sol";
```

###### To import `ShambaFireConsumer` contract:

```solidity
import {ShambaFireConsume} from "@shambadynamic/contracts/contracts/ShambaFireConsumer.sol";
```

## Local Development

```
# Clone Shamba Smart-Contract-Kit repository
$ git clone https://github.com/shambadynamic/shamba-smartcontractkit
$ cd contracts/
```
