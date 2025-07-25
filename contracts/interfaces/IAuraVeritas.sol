// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IAuraVeritas {
    // Defines all external-facing functions for easy integration by partners.
    event ProtocolStaked(address indexed protocol, uint256 amount);
    event ProtocolUnstaked(address indexed protocol, uint256 amount);

    function stake(uint256 amount) external;
    function unstake(uint256 amount) external;
    function protocolStakes(address protocol) external view returns (uint256);
    function isVerifiedAddress(address user) external view returns (bool);
}