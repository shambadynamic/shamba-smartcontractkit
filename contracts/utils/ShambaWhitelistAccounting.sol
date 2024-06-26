//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract ShambaWhitelistAccounting {
    error ShambaWhitelistAccounting__NeitherWhitelistedAddressNorWhitelistingManager();
    error ShambaWhitelistAccounting__NotWhitelistingManager();
    error ShambaWhitelistAccounting__AlreadyWhitelisted();
    error ShambaWhitelistAccounting__NotWhitelisted();
    error ShambaWhitelistAccounting__InvalidIndex();

    // whitelist accounting
    address private s_whitelistingManager =
        0x8C244f0B2164E6A3BED74ab429B0ebd661Bb14CA;
    mapping(address => bool) private s_isWhitelisted;
    address[] private s_whitelistedAddresses;

    /// @notice Called by whitelisting manager to whitelist the passed address.
    /// @param _address       Address to be whitelisted
    function addAddressToWhitelist(
        address _address
    ) external onlyWhitelistingManager {
        if (s_isWhitelisted[_address])
            revert ShambaWhitelistAccounting__AlreadyWhitelisted();
        s_isWhitelisted[_address] = true;
        s_whitelistedAddresses.push(_address);
    }

    /// @notice Called by whitelisting manager to remove the passed address from the list of whitelisted addresses.
    /// @param _address               Address to be removed from the list of whitelisted addresses
    /// @param whitelistIndex     Index of the address to be removed from the list of whitelisted addresses
    function removeAddressFromWhitelist(
        address _address,
        uint256 whitelistIndex
    ) external onlyWhitelistingManager {
        if (!s_isWhitelisted[_address])
            revert ShambaWhitelistAccounting__NotWhitelisted();

        if (s_whitelistedAddresses[whitelistIndex] != _address)
            revert ShambaWhitelistAccounting__InvalidIndex();

        s_isWhitelisted[_address] = false;

        address temp = s_whitelistedAddresses[whitelistIndex];

        s_whitelistedAddresses[whitelistIndex] = s_whitelistedAddresses[
            s_whitelistedAddresses.length - 1
        ];

        s_whitelistedAddresses[s_whitelistedAddresses.length - 1] = temp;

        s_whitelistedAddresses.pop();
    }

    /// @notice Called by the current whitelisting manager to change the whitelisting manager.
    /// @param _address       Address to be set as whitelisting manager
    function changeWhitelistingManager(
        address _address
    ) external onlyWhitelistingManager {
        s_whitelistingManager = _address;
    }

    /* GETTERS */

    function getWhitelistingManager() external view returns (address) {
        return s_whitelistingManager;
    }

    function isWhitelisted(address _address) external view returns (bool) {
        return s_isWhitelisted[_address];
    }

    function getWhitelistedAddresses()
        external
        view
        returns (address[] memory)
    {
        return s_whitelistedAddresses;
    }

    function getWhitelistedAddressAtIndex(
        uint256 index
    ) external view returns (address) {
        return s_whitelistedAddresses[index];
    }

    function getIndexOfWhitelistedAddress(
        address whitelistedAddress
    ) external view returns (int256) {
        for (uint256 i = 0; i < s_whitelistedAddresses.length; i++) {
            if (s_whitelistedAddresses[i] == whitelistedAddress)
                return int256(i);
        }
        return -1;
    }

    /* MODIFIERS */

    modifier onlyWhitelistedAddress() {
        if (
            !s_isWhitelisted[msg.sender] &&
            msg.sender != s_whitelistingManager &&
            tx.origin != s_whitelistingManager
        ) {
            revert ShambaWhitelistAccounting__NeitherWhitelistedAddressNorWhitelistingManager();
        }
        _;
    }

    modifier onlyWhitelistingManager() {
        if (
            msg.sender != s_whitelistingManager &&
            tx.origin != s_whitelistingManager
        ) {
            revert ShambaWhitelistAccounting__NotWhitelistingManager();
        }
        _;
    }
}
