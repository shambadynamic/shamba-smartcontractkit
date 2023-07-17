//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "./utils/ShambaChainSelector.sol";
import "./utils/ShambaWhitelistAccounting.sol";

contract ShambaFireConsumer is ChainlinkClient, ShambaChainSelector, ShambaWhitelistAccounting {
    using Chainlink for Chainlink.Request;
    ShambaChainSelector shambaChainSelector;
    mapping(uint256 => uint256) private fire_data;
    string private cid;
    uint256 public total_oracle_calls = 0;
    mapping(uint256 => string) private cids;

    /// @param chain_id    ETH Chain Id of the network on which the contract is getting deployed
    constructor(uint64 chain_id) ShambaChainSelector(chain_id) {
        shambaChainSelector = new ShambaChainSelector(chain_id);
        setChainlinkToken(shambaChainSelector.linkTokenContractAddress());
        setChainlinkOracle(shambaChainSelector.operatorAddress());
    }

    /// @notice Called by a user to send a request to the Shamba Oracle.
    /// @param requestIpfsCid    You can get the requestIpfsCid using Shamba Contracts Tool available at https://contracts.shamba.app
    function requestFireData(
        string memory requestIpfsCid
    ) public onlyWhitelistedAddress {

        Chainlink.Request memory req = buildChainlinkRequest(
            shambaChainSelector.jobSpecId("fire-analysis"),
            address(this),
            this.fulfillFireData.selector
        );

        req.add("data", requestIpfsCid);

        if (shambaChainSelector.chainId() == 137 || shambaChainSelector.chainId() == 200101) {
            sendOperatorRequest(req, 0);
        }
        else {
            sendOperatorRequest(req, 10**18);
        }
    }

    /// @notice Called by the Shamba Oracle after the request being sent successfully.
    function fulfillFireData(
        bytes32 requestId,
        uint256[] memory fireData,
        string calldata cidValue
    ) public recordChainlinkFulfillment(requestId) {
        
        for (uint256 i = 0; i < fireData.length; i++) {
            fire_data[i + 1] = fireData[i];
        }

        cid = cidValue;
        cids[total_oracle_calls] = cid;
        total_oracle_calls = total_oracle_calls + 1;
    }

    /// @notice Called by a user to get the latest fire data returned by the Shamba Oracle corresponding to a particular propertyID.
    /// @param propertyID      Property Id of the polygon or area drawn on the Shamba Contracts Tool available at https://contracts.shamba.app
    function getLatestFireData(uint256 propertyID) public view returns (uint256) {
        return fire_data[propertyID];
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