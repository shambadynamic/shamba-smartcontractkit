//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ShambaOperatorSelector {
    function operatorAddress(uint256 operator_number)
        external
        pure
        returns (address)
    {
        if (operator_number == 1) {
            return 0x3706bdD2d30474a5069E1451AB860a2570B1c249;
        } else if (operator_number == 2) {
            return 0x60661168F1228E62403e804813979588D0C17e3B;
        } else if (operator_number == 3) {
            return 0xBB370F829bdB6fC44f3D34e2A2107578bB2c3F0B;
        } else if (operator_number == 4) {
            return 0xA5045D3Fd2B84e527713fcEFA2F73Def48601288;
        } else if (operator_number == 5) {
            return 0x105a6BC318dCF3Fc73472c8833ccD7c684449B90;
        } else if (operator_number == 6) {
            return 0xAb40bb95B79b62c9145C475d52eA07e0e1c576e3;
        } else if (operator_number == 7) {
            return 0xf77f8d0691F15c4F4B51cd1Fb6B8d9C9fd5143D9;
        } else {
            return 0x0000000000000000000000000000000000000000;
        }
    }

    function linkTokenContractAddress(uint256 operator_number)
        external
        pure
        returns (address)
    {
        if (operator_number == 1) {
            return 0x615fBe6372676474d9e6933d310469c9b68e9726;
        } else if (operator_number == 2) {
            return 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;
        } else if (operator_number == 3) {
            return 0x84b9B910527Ad5C03A9Ca831909E21e236EA7b06;
        } else if (operator_number == 4) {
            return 0x326C977E6efc84E512bB9C30f76E30c160eD06FB;
        } else if (operator_number == 5) {
            return 0x01BE23585060835E02B77ef475b0Cc51aA1e0709;
        } else if (operator_number == 6) {
            return 0x3706bdD2d30474a5069E1451AB860a2570B1c249;
        } else if (operator_number == 7) {
            return 0x326C977E6efc84E512bB9C30f76E30c160eD06FB;
        } else {
            return 0x0000000000000000000000000000000000000000;
        }
    }

    function networkOfOperator(uint256 operator_number)
        external
        pure
        returns (string memory)
    {
        if (operator_number == 1) {
            return "Arbitrum Rinkeby";
        } else if (operator_number == 2) {
            return "Avalanche Fuji";
        } else if (operator_number == 3) {
            return "Binance Testnet";
        } else if (operator_number == 4) {
            return "Ethereum Goerli";
        } else if (operator_number == 5) {
            return "Ethereum Rinkeby";
        } else if (operator_number == 6) {
            return "Moonbase Alpha";
        } else if (operator_number == 7) {
            return "Polygon Mumbai";
        } else {
            return "";
        }
    }

    function jobSpecId(
        uint256 operator_number,
        string memory geospatial_category
    ) external pure returns (bytes32) {
        if (operator_number == 1) {
            if (compareStringsbyBytes(geospatial_category, "geo-statistics")) {
                return "22a7384d4e6847c9ad49daf957affdeb";
            } else if (
                compareStringsbyBytes(geospatial_category, "fire-analysis")
            ) {
                return "d639f8147c83430fa0163b146935eb5e";
            } else {
                return "";
            }
        } else if (operator_number == 2) {
            if (compareStringsbyBytes(geospatial_category, "geo-statistics")) {
                return "72d96a5ce05a46b3be8ab37d62beae4f";
            } else if (
                compareStringsbyBytes(geospatial_category, "fire-analysis")
            ) {
                return "a44034ab41374ee8883bcd4a19677943";
            } else {
                return "";
            }
        } else if (operator_number == 3) {
            if (compareStringsbyBytes(geospatial_category, "geo-statistics")) {
                return "6563c135372a470881b7ffe2b7d80a0d";
            } else if (
                compareStringsbyBytes(geospatial_category, "fire-analysis")
            ) {
                return "a5478a47ce7c490b82d70fd490fd7f9b";
            } else {
                return "";
            }
        } else if (operator_number == 4) {
            if (compareStringsbyBytes(geospatial_category, "geo-statistics")) {
                return "6bc884ca1f8e4e7384896f3cd74e679c";
            } else if (
                compareStringsbyBytes(geospatial_category, "fire-analysis")
            ) {
                return "0d0036decab7402b904e038211d40996";
            } else {
                return "";
            }
        } else if (operator_number == 5) {
            if (compareStringsbyBytes(geospatial_category, "geo-statistics")) {
                return "f36e1bf64c904bb1864ae06093a69fe6";
            } else if (
                compareStringsbyBytes(geospatial_category, "fire-analysis")
            ) {
                return "5633f75576e94d3bbe604f7e0a7cf3db";
            } else {
                return "";
            }
        } else if (operator_number == 6) {
            if (compareStringsbyBytes(geospatial_category, "geo-statistics")) {
                return "0e4428bd941545a68f1dcb00c33d454a";
            } else if (
                compareStringsbyBytes(geospatial_category, "fire-analysis")
            ) {
                return "ac1e7b2794e9492dacbf578d4925b083";
            } else {
                return "";
            }
        } else if (operator_number == 7) {
            if (compareStringsbyBytes(geospatial_category, "geo-statistics")) {
                return "4e50c49eb10a4e0ebe68e0efcd40548d";
            } else if (
                compareStringsbyBytes(geospatial_category, "fire-analysis")
            ) {
                return "9604e1bba4a1476db33efdd3eb915784";
            } else {
                return "";
            }
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
