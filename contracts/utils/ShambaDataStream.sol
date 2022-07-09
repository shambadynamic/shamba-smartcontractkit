// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./ShambaDONSelector.sol";

contract ShambaDataStream is ShambaDONSelector {
    AggregatorV3Interface internal dataStream;
    uint256 current_DON_number;

    /**
     * Initialize with DON number and data stream code
     */
    constructor(uint256 DON_number, string memory data_stream_code) {
        current_DON_number = DON_number;
        dataStream = AggregatorV3Interface(
            ShambaDONSelector.fluxAggregatorAddress(
                DON_number,
                data_stream_code
            )
        );
    }

    /**
     * Returns the latest temperature
     */
    function getLatestData() public view returns (int256) {
        (
            ,
            /*uint80 roundID*/
            int256 data,
            ,
            ,

        ) = /*uint startedAt*/
            /*uint timeStamp*/
            /*uint80 answeredInRound*/
            dataStream.latestRoundData();
        return data;
    }

    /**
     * Returns the number of nodes in selected DON
     */
    function numberOfNodes() public view returns (uint256) {
        return ShambaDONSelector.numberOfNodes(current_DON_number);
    }

    /**
     * Returns the network of selected DON
     */
    function networkOfDON() public view returns (string memory) {
        return ShambaDONSelector.networkOfDON(current_DON_number);
    }

    /**
     * Returns the list of data streams provided by selected DON
     */

    function availableDataStreams() public returns (string[] memory) {
        return
            ShambaDONSelector.availableDataStreamsProvidedByDON(
                current_DON_number
            );
    }
}
