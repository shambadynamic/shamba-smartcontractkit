//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ChainlinkClient, Chainlink} from "@chainlink/contracts@1.1.1/src/v0.8/ChainlinkClient.sol";
import {ShambaWhitelistAccounting} from "./utils/ShambaWhitelistAccounting.sol";
import {NetworkConfig} from "./utils/libraries/NetworkConfig.sol";

contract ShambaFireConsumer is ChainlinkClient, ShambaWhitelistAccounting {
    using Chainlink for Chainlink.Request;

    mapping(uint256 => uint256) private s_latestFireData;
    uint256 private s_latestFireDataLength;
    string private s_latestIpfsCid;
    uint256 public s_totalOracleCalls = 0;
    mapping(uint256 => string) private s_ipfsCids;

    constructor() {
        _setChainlinkToken(NetworkConfig.getLinkTokenAddress(block.chainid));
        _setChainlinkOracle(NetworkConfig.getOperatorAddress(block.chainid));
    }

    function resetLatestFireData() internal {
        s_latestIpfsCid = "";
        for (uint256 i = 0; i < s_latestFireDataLength; i++) {
            s_latestFireData[i + 1] = 0;
        }
    }

    /// @notice Called by a user to send a request to the Shamba Oracle.
    /// @param requestBody    requestBody can be either a url containing the actual JSON request body or a hex string representing the bytes encoded JSON request body. You can get the requestBody in any of these formats using Shamba Contracts Tool available at https://contracts.shamba.app. The former one is recommended for large (in terms of number of coordinates) geoJSONs and the latter one is recommended for rectangular geoJSONs and for faster turnaround/response times.
    function requestFireData(
        string memory requestBody
    ) public onlyWhitelistedAddress {
        resetLatestFireData();

        Chainlink.Request memory req = _buildChainlinkRequest(
            NetworkConfig.getJobSpecId("fire-analysis"),
            address(this),
            this.fulfillFireData.selector
        );

        req._add("data", requestBody);

        _sendOperatorRequest(req, 0);
    }

    /// @notice Called by the Shamba Oracle after the request being sent successfully.
    function fulfillFireData(
        bytes32 requestId,
        uint256[] memory fireData,
        string calldata cidValue
    ) public recordChainlinkFulfillment(requestId) {
        for (uint256 i = 0; i < fireData.length; i++) {
            s_latestFireData[i + 1] = fireData[i];
            s_latestFireDataLength += 1;
        }

        s_latestIpfsCid = cidValue;
        s_ipfsCids[s_totalOracleCalls] = s_latestIpfsCid;
        s_totalOracleCalls = s_totalOracleCalls + 1;
    }

    /// @notice Called by a user to get the latest fire data returned by the Shamba Oracle corresponding to a particular propertyID.
    /// @param propertyID      Property Id of the polygon or area drawn on the Shamba Contracts Tool available at https://contracts.shamba.app
    function getLatestFireData(
        uint256 propertyID
    ) public view returns (uint256) {
        return s_latestFireData[propertyID];
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
