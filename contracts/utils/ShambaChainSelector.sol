//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ShambaChainSelector {
    uint64 public chainId;

    constructor(uint64 chain_id) {
        chainId = chain_id;
    }

    function operatorAddress() external view returns (address) {
        if (chainId == 43113) {
            return 0x60661168F1228E62403e804813979588D0C17e3B;
        } else if (chainId == 97) {
            return 0xBB370F829bdB6fC44f3D34e2A2107578bB2c3F0B;
        } else if (chainId == 5) {
            return 0xA5045D3Fd2B84e527713fcEFA2F73Def48601288;
        } else if (chainId == 420) {
            return 0xBB370F829bdB6fC44f3D34e2A2107578bB2c3F0B;
        } else if (chainId == 80001) {
            return 0x6D5BdcB8B5672E809a1f8c088efe53c9153e5f3C;
        } else if (chainId == 137) {
            return 0x67F98d5f668a4408a72a9EeE4831bFe098a2Fed6;
        } else if (chainId == 200101) {
            return 0xAb40bb95B79b62c9145C475d52eA07e0e1c576e3;
        } else {
            return address(0);
        }
    }

    function linkTokenContractAddress() external view returns (address) {
        if (chainId == 43113) {
            return 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;
        } else if (chainId == 97) {
            return 0x84b9B910527Ad5C03A9Ca831909E21e236EA7b06;
        } else if (chainId == 5) {
            return 0x326C977E6efc84E512bB9C30f76E30c160eD06FB;
        } else if (chainId == 420) {
            return 0xdc2CC710e42857672E7907CF474a69B63B93089f;
        } else if (chainId == 80001) {
            return 0x326C977E6efc84E512bB9C30f76E30c160eD06FB;
        } else if (chainId == 137) {
            return 0xb0897686c545045aFc77CF20eC7A532E3120E0F1;
        } else if (chainId == 200101) {
            return 0x26E52c99238fea58A4AafDc1Ee3775D19BCc39fb;
        } else {
            return address(0);
        }
    }

    function blockchainNetwork() external view returns (string memory) {
        if (chainId == 43113) {
            return "Avalanche Fuji";
        } else if (chainId == 97) {
            return "Binance Testnet";
        } else if (chainId == 5) {
            return "Ethereum Goerli";
        } else if (chainId == 420) {
            return "Optimism Goerli";
        } else if (chainId == 80001) {
            return "Polygon Mumbai";
        } else if (chainId == 137) {
            return "Polygon Mainnet";
        } else if (chainId == 200101) {
            return "Milkomeda-C1 Testnet";
        } else {
            return "";
        }
    }

    function jobSpecId(string memory geospatial_category)
        external
        pure
        returns (bytes32)
    {
        if (compareStringsbyBytes(geospatial_category, "geo-statistics")) {
            return "9c4b3838c5cd4f02acbb0aef5c81567c";
        } else if (
            compareStringsbyBytes(geospatial_category, "fire-analysis")
        ) {
            return "f42b8d9cf9b54f7b9cf3ab4df53d6df3";
        } else if (compareStringsbyBytes(geospatial_category, "sni-lap")) {
            return "d4c11c35b72142a984eb888236682f08";
        } else if (compareStringsbyBytes(geospatial_category, "sni-hwc")) {
            return "9157b0702f8e4ca7b805c1e0a589f9da";
        } else {
            return "";
        }
    }

    function compareStringsbyBytes(string memory s1, string memory s2)
        private
        pure
        returns (bool)
    {
        return
            keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
    }
}
