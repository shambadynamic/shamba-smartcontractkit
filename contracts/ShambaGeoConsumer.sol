//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ChainlinkClient, Chainlink} from "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import {ShambaWhitelistAccounting} from "./utils/ShambaWhitelistAccounting.sol";
import {NetworkConfig} from "./utils/libraries/NetworkConfig.sol";

contract ShambaGeoConsumer is ChainlinkClient, ShambaWhitelistAccounting {
    using Chainlink for Chainlink.Request;

    int256 private s_latestGeostatsData;
    string private s_latestIpfsCid;
    uint256 public s_totalOracleCalls = 0;
    mapping(uint256 => string) private s_ipfsCids;

    constructor() {
        _setChainlinkToken(NetworkConfig.getLinkTokenAddress(block.chainid));
        _setChainlinkOracle(NetworkConfig.getOperatorAddress(block.chainid));
    }

    /// @notice Called by a whitelisted user to send a request to the Shamba Oracle.
    /// @param requestBody     requestBody can be either a url containing the actual JSON request body or a hex string representing the bytes encoded JSON request body. You can get the requestBody in any of these formats using Shamba Contracts Tool available at https://contracts.shamba.app. The former one is recommended for large (in terms of number of coordinates) geoJSONs and the later one is recommended for rectangular geoJSONs and for faster turnaround/response times.
    function requestGeostatsData(
        string calldata requestBody
    ) public onlyWhitelistedAddress {
        s_latestGeostatsData = -1;
        s_latestIpfsCid = "";

        Chainlink.Request memory req = _buildChainlinkRequest(
            NetworkConfig.getJobSpecId("geo-statistics"),
            address(this),
            this.fulfillGeostatsData.selector
        );

        req._add("data", requestBody);

        _sendOperatorRequest(req, 0);
    }

    /// @notice Called by the Shamba Oracle after the request being sent successfully.
    function fulfillGeostatsData(
        bytes32 requestId,
        int256 geostatsData,
        string calldata cidValue
    ) public recordChainlinkFulfillment(requestId) {
        s_latestGeostatsData = geostatsData;
        s_latestIpfsCid = cidValue;
        s_ipfsCids[s_totalOracleCalls] = s_latestIpfsCid;
        s_totalOracleCalls = s_totalOracleCalls + 1;
    }

    /* GETTERS */

    /// @notice Called by a user to get the latest geostats data returned by the Shamba Oracle.
    function getLatestGeostatsData() public view returns (int256) {
        return s_latestGeostatsData;
    }

    /// @notice Called by a user to get the latest IPFS Content Identifier containing the latest request sent to the Shamba Oracle and the corresponding response.
    function getLatestIpfsCid() public view returns (string memory) {
        return s_latestIpfsCid;
    }

    /// @notice Called by a user to get the IPFS Content Identifier at a particular index containing the latest request sent to the Shamba Oracle and the corresponding response.
    /// @param index       Index corresponding to the s_ipfsCids mapping
    function getIpfsCidAtIndex(
        uint256 index
    ) public view returns (string memory) {
        return s_ipfsCids[index];
    }
}
