# Aura Veritas Protocol

![Aura Veritas Logo](https://i.ibb.co/gFdTV9Bq/Veritas.png)

**A multi-layered security and utility protocol for the Gnosis ecosystem, powered by the Veritas Token (VRT).**

---

## Abstract

Aura Veritas is a mission-driven protocol designed to address critical security and infrastructure gaps in decentralized finance. Our innovation stack provides a suite of protocol-level services—from oracle security to institutional compliance—creating a safer and more robust environment for protocols and users on the Gnosis Chain. The VRT token is the core utility asset that powers these services.

## The Innovation Stack

Aura Veritas is not a single product, but a suite of four interoperable protocol layers:

*   **Layer 1: Dynamic Stability Fee (DSF)**
    A foundational mechanism that protects asset stability. A dormant fee can activate during market extremes to fund a protocol-owned treasury used to deepen liquidity, directly benefiting the security of all integrated partners.

*   **Layer 2: Veritas Oracle Attestation Layer (VOAL)**
    A decentralized service providing secondary oracle price confirmations to combat manipulation. Partner protocols can stake VRT to access this network, adding a crucial layer of security to their operations.

*   **Layer 3: Aura Governance Shield (AGS)**
    A "Governance-as-a-Service" framework. New DAOs can stake VRT to deploy our audited, timelocked treasury contracts, preventing common governance attacks and securing the wider ecosystem.

*   **Layer 4: Opt-In Identity Attestation**
    A forward-looking compliance framework. VRT holders can voluntarily choose to link their address to credentials, creating an asset ready for institutional-grade, permissioned DeFi pools—a key growth area for major protocols.

---

## Core Infrastructure & Deployment

This repository contains the official, audited V1 smart contracts for the Aura Veritas Protocol.

*   **Official Token (Proxy) Address:** [`0xF176FEbAFCcf1e0805E1EfE4276619040003eaeb`](https://gnosisscan.io/address/0xF176FEbAFCcf1e0805E1EfE4276619040003eaeb)
*   **V1 Implementation Address:** [`0x26Ef460B92666ba7233eb7b69431D4273ac1De43`](https://gnosisscan.io/address/0x26Ef460B92666ba7233eb7b69431D4273ac1De43)
*   **Primary Liquidity Pool (Balancer):** [`Pool`] (https://balancer.fi/pools/gnosis/v3/0x39b466E933735b9870Ef1552b096E15107164353)

### Security & Governance

The protocol is governed by the Aura Veritas Foundation, a decentralized entity. All administrative functions are controlled by a **3-of-4 Gnosis Safe multi-signature wallet**, ensuring no single point of failure.

*   **Foundation Treasury (Gnosis Safe):** [`0x07769243D608fC7BeE30c935600dAA73502c90f6`](https://gnosisscan.io/address/0x07769243D608fC7BeE30c935600dAA73502c90f6)

---

## Development & Testing

This project is built using the Hardhat development environment. All contracts are thoroughly tested.

### Run Tests
To run the full test suite locally after cloning the repository:
```bash
npm install
npx hardhat test
```

## Community

*   **Website:** [https://therealveritas.github.io/](https://therealveritas.github.io/)
*   **Twitter:** [@VeritasFNDN](https://x.com/VeritasFNDN)

