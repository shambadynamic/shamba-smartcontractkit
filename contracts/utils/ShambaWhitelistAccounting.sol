//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ShambaWhitelistAccounting {

    // whitelist accounting
    address public whitelistingManager = 0x8C244f0B2164E6A3BED74ab429B0ebd661Bb14CA;
    mapping(address => bool) public isWhitelisted;
    address[] public whitelistedAddresses;

    /// @notice Called by whitelisting manager to whitelist the passed address.
    /// @param addr       Address to be whitelisted 
    function addAddressToWhitelist(address addr) external onlyWhitelistingManager {  
        require(
            !isWhitelisted[addr],
            "address must not be already whitelisted"
        );
        isWhitelisted[addr] = true;
        whitelistedAddresses.push(addr);
    }

    /// @notice Called by whitelisting manager to remove the passed address from the list of whitelisted addresses.
    /// @param addr               Address to be removed from the list of whitelisted addresses 
    /// @param whitelistIndex     Index of the address to be removed from the list of whitelisted addresses 
    function removeAddressFromWhitelist(
        address addr,
        uint whitelistIndex
    ) external onlyWhitelistingManager {
        require(
            isWhitelisted[addr],
            "can only remove whitelisted addresses"
        );
        require(
            whitelistedAddresses[whitelistIndex] == addr,
            "index does not match address"
        );
  
        isWhitelisted[addr] = false;

        address temp = whitelistedAddresses[whitelistIndex];

        whitelistedAddresses[whitelistIndex] = whitelistedAddresses[whitelistedAddresses.length - 1];

        whitelistedAddresses[whitelistedAddresses.length - 1] = temp;

        whitelistedAddresses.pop();

    }

    /// @notice Called by the current whitelisting manager to change the whitelisting manager.
    /// @param addr       Address to be set as whitelisting manager
    function changeWhitelistingManager(address addr) external onlyWhitelistingManager {  
        whitelistingManager = addr;
    }

    modifier onlyWhitelistedAddress {
        require(isWhitelisted[msg.sender] || msg.sender == whitelistingManager || tx.origin == whitelistingManager);
        _;
    }

    modifier onlyWhitelistingManager {
        require(msg.sender == whitelistingManager || tx.origin == whitelistingManager);
        _;
    }
}