// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract AuraVeritas_Implementation_v1 is ERC20, AccessControl, ReentrancyGuard {
    bytes32 public constant FOUNDATION_ROLE = keccak256("FOUNDATION_ROLE");
    bytes32 public constant ATTESTATION_CLERK_ROLE = keccak256("ATTESTATION_CLERK_ROLE");

    bool public dsfActive;
    uint256 public dsfFeeBps;
    address public dsfTreasury;

    mapping(address => uint256) public protocolStakes;
    mapping(address => bool) public isVerifiedAddress;

    event DsfStateChanged(bool newState);
    event DsfParametersUpdated(uint256 newFeeBps, address newTreasury);
    event ProtocolStaked(address indexed protocol, uint256 amount);
    event ProtocolUnstaked(address indexed protocol, uint256 amount);
    event AddressAttestationChanged(address indexed user, bool newStatus);

    constructor() ERC20("Aura Veritas Token", "VRT") {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(FOUNDATION_ROLE, msg.sender);
        _setupRole(ATTESTATION_CLERK_ROLE, msg.sender);
        _mint(msg.sender, 100000000 * 10**18);
        dsfTreasury = msg.sender;
    }

    /**
     * @dev Overridden _transfer function. The nonReentrant guard has been removed from this internal
     * function to resolve lock collisions with the public-facing stake/unstake functions,
     * which are the true entry points that need to be guarded.
     */
    function _transfer(address from, address to, uint256 amount) internal override {
        // The core bug fix: We only apply DSF logic if it's a real user transfer, NOT a mint (from != address(0)).
        if (dsfActive && from != address(0)) {
            uint256 fee = (amount * dsfFeeBps) / 10000;
            if (fee > 0) {
                uint256 transferAmount = amount - fee;
                super._transfer(from, to, transferAmount);
                super._transfer(from, dsfTreasury, fee);
            } else {
                // Fee is zero, proceed with normal transfer
                super._transfer(from, to, amount);
            }
        } else {
            // DSF is off or it's a mint operation, proceed with normal transfer
            super._transfer(from, to, amount);
        }
    }

    function stake(uint256 amount) external nonReentrant {
        require(amount > 0, "Stake amount must be > 0");
        protocolStakes[msg.sender] += amount;
        _transfer(msg.sender, address(this), amount); // Will correctly use our UNGUARDED overridden _transfer
        emit ProtocolStaked(msg.sender, amount);
    }

    function unstake(uint256 amount) external nonReentrant {
        require(amount > 0, "Unstake amount must be > 0");
        require(protocolStakes[msg.sender] >= amount, "Insufficient staked balance");
        protocolStakes[msg.sender] -= amount;
        _transfer(address(this), msg.sender, amount); // Will correctly use our UNGUARDED overridden _transfer
        emit ProtocolUnstaked(msg.sender, amount);
    }
    
    // --- Governance Functions Remain Unchanged ---
    function setDsfActive(bool _newState) external onlyRole(FOUNDATION_ROLE) {
        dsfActive = _newState;
        emit DsfStateChanged(_newState);
    }

    function setDsfParameters(uint256 _newFeeBps, address _newTreasury) external onlyRole(FOUNDATION_ROLE) {
        require(_newFeeBps <= 100, "Fee cannot exceed 1%");
        require(_newTreasury != address(0), "Zero address");
        dsfFeeBps = _newFeeBps;
        dsfTreasury = _newTreasury;
        emit DsfParametersUpdated(_newFeeBps, _newTreasury);
    }
    
    function setVerifiedAddress(address _user, bool _status) external onlyRole(ATTESTATION_CLERK_ROLE) {
        isVerifiedAddress[_user] = _status;
        emit AddressAttestationChanged(_user, _status);
    }
}