//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "./utils/ShambaChainSelector.sol";
import "./utils/ShambaWhitelistAccounting.sol";

contract ShambaGeoConsumer is ChainlinkClient, ShambaChainSelector, ShambaWhitelistAccounting {
    using Chainlink for Chainlink.Request;
    ShambaChainSelector shambaChainSelector;
    int256 private geostats_data;
    string private cid;
    uint256 public total_oracle_calls = 0;
    mapping(uint256 => string) private cids;

    /// @param chain_id    ETH Chain Id of the network on which the contract is getting deployed
    constructor(uint256 chain_id) ShambaChainSelector(chain_id) {
        shambaChainSelector = new ShambaChainSelector(chain_id);
        setChainlinkToken(shambaChainSelector.linkTokenContractAddress());
        setChainlinkOracle(shambaChainSelector.operatorAddress());
    }

    /// @notice Called by a whitelisted user to send a request to the Shamba Oracle.
    /// @param requestIpfsCid    You can get the requestIpfsCid using Shamba Contracts Tool available at https://contracts.shamba.app
    function requestGeostatsData(
        string memory requestIpfsCid
    ) public onlyWhitelistedAddress {

        geostats_data = -1;
        cid = "";

        Chainlink.Request memory req = buildChainlinkRequest(
            shambaChainSelector.jobSpecId("geo-statistics"),
            address(this),
            this.fulfillGeostatsData.selector
        );

        req.add("data", requestIpfsCid);

        sendOperatorRequest(req, 0);
    }

    /// @notice Called by the Shamba Oracle after the request being sent successfully.
    function fulfillGeostatsData(
        bytes32 requestId,
        int256 geostatsData,
        string calldata cidValue
    ) public recordChainlinkFulfillment(requestId) {
        geostats_data = geostatsData;
        cid = cidValue;
        cids[total_oracle_calls] = cid;
        total_oracle_calls = total_oracle_calls + 1;
    }

    /// @notice Called by a user to get the latest geostats data returned by the Shamba Oracle.
    function getLatestGeostatsData() public view returns (int256) {
        return geostats_data;
    }

    /// @notice Called by a user to get the latest IPFS Content Identifier containing the latest request sent to the Shamba Oracle and the corresponding response.
    function getLatestCid() public view returns (string memory) {
        return cid;
    }

    /// @notice Called by a user to get the IPFS Content Identifier at a particular index containing the latest request sent to the Shamba Oracle and the corresponding response.
    /// @param index       Index corresponding to the cids mapping 
    function getCid(uint256 index) public view returns (string memory) {
        return cids[index];
    }

}