const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Aura Veritas Protocol V1", function () {
    let VRT, vrt, owner, addr1, addr2;
    const FOUNDATION_ROLE = ethers.keccak256(ethers.toUtf8Bytes("FOUNDATION_ROLE"));

    // The "before each" hook that was failing. It sets up the test environment.
    beforeEach(async function () {
        [owner, addr1, addr2] = await ethers.getSigners();
        VRT = await ethers.getContractFactory("AuraVeritas_Implementation_v1");
        vrt = await VRT.deploy();
    });

    it("Should deploy correctly with the right name, symbol, and roles", async function () {
        expect(await vrt.name()).to.equal("Aura Veritas Token");
        expect(await vrt.symbol()).to.equal("VRT");
        expect(await vrt.hasRole(FOUNDATION_ROLE, owner.address)).to.be.true;
    });

    it("DSF fee should be off by default and transfers should work normally", async function () {
        await vrt.transfer(addr1.address, 1000);
        expect(await vrt.balanceOf(addr1.address)).to.equal(1000);
    });

    it("Foundation should be able to activate and configure DSF", async function () {
        await expect(vrt.connect(addr1).setDsfActive(true)).to.be.reverted; // Check permissions
        
        await vrt.setDsfParameters(50, addr2.address); // 0.5% fee to addr2
        await vrt.setDsfActive(true);
        
        // Corrected Test Logic:
        await vrt.transfer(addr1.address, 10000);
        
        // The recipient should get the amount minus the fee.
        expect(await vrt.balanceOf(addr1.address)).to.equal(9950); // 10000 - 50
        // The treasury should get the fee.
        expect(await vrt.balanceOf(addr2.address)).to.equal(50); // 0.5% of 10000
    });

    it("Users should be able to stake and unstake", async function () {
        await vrt.transfer(addr1.address, 5000);
        
        await vrt.connect(addr1).stake(1000);
        expect(await vrt.protocolStakes(addr1.address)).to.equal(1000);
        expect(await vrt.balanceOf(addr1.address)).to.equal(4000);

        await vrt.connect(addr1).unstake(500);
        expect(await vrt.protocolStakes(addr1.address)).to.equal(500);
        expect(await vrt.balanceOf(addr1.address)).to.equal(4500);
    });
});