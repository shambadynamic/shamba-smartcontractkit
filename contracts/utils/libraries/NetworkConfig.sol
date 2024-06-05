// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

library NetworkConfig {
    error NetworkConfig__NetworkNotSupported();

    function getOperatorAddress(
        uint256 chainId
    ) internal pure returns (address operatorAddress) {
        if (chainId == 43113) {
            operatorAddress = 0x60661168F1228E62403e804813979588D0C17e3B;
        } else if (chainId == 84532) {
            operatorAddress = 0x6e3bF39C2aBfc1c706B89AD4979843ca8B37D7b3;
        } else if (chainId == 97) {
            operatorAddress = 0xBB370F829bdB6fC44f3D34e2A2107578bB2c3F0B;
        } else if (chainId == 137) {
            operatorAddress = 0x67F98d5f668a4408a72a9EeE4831bFe098a2Fed6;
        } else if (chainId == 200101) {
            operatorAddress = 0xAb40bb95B79b62c9145C475d52eA07e0e1c576e3;
        } else if (chainId == 1440002) {
            operatorAddress = 0xf8A6b3b38895C861C37F93EF8058F54B7c16fe75;
        } else {
            revert NetworkConfig__NetworkNotSupported();
        }
    }

    function getLinkTokenAddress(
        uint256 chainId
    ) internal pure returns (address linkTokenAddress) {
        if (chainId == 43113) {
            linkTokenAddress = 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;
        } else if (chainId == 84532) {
            linkTokenAddress = 0xE4aB69C077896252FAFBD49EFD26B5D171A32410;
        } else if (chainId == 97) {
            linkTokenAddress = 0x84b9B910527Ad5C03A9Ca831909E21e236EA7b06;
        } else if (chainId == 137) {
            linkTokenAddress = 0xb0897686c545045aFc77CF20eC7A532E3120E0F1;
        } else if (chainId == 200101) {
            linkTokenAddress = 0x26E52c99238fea58A4AafDc1Ee3775D19BCc39fb;
        } else if (chainId == 1440002) {
            linkTokenAddress = 0xCCB61d7BAA37E029d3ee654A0DC1cdAE06F56f0C;
        } else {
            linkTokenAddress = address(0);
        }
    }

    function getJobSpecId(
        string memory geospatial_category
    ) internal pure returns (bytes32 jobSpecId) {
        if (compareStringsbyBytes(geospatial_category, "geo-statistics")) {
            jobSpecId = "9c4b3838c5cd4f02acbb0aef5c81567c";
        } else if (
            compareStringsbyBytes(geospatial_category, "fire-analysis")
        ) {
            jobSpecId = "f42b8d9cf9b54f7b9cf3ab4df53d6df3";
        } else if (compareStringsbyBytes(geospatial_category, "sni-lap")) {
            jobSpecId = "d4c11c35b72142a984eb888236682f08";
        } else if (compareStringsbyBytes(geospatial_category, "sni-hwc")) {
            jobSpecId = "9157b0702f8e4ca7b805c1e0a589f9da";
        } else {
            jobSpecId = "";
        }
    }

    function compareStringsbyBytes(
        string memory s1,
        string memory s2
    ) internal pure returns (bool) {
        return
            keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
    }
}
