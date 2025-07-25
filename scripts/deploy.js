const { ethers } = require("hardhat");

async function main() {
    console.log("Preparing deployment...");
    const [deployer] = await ethers.getSigners();

    // Deploy the V1 Implementation
    const V1_Factory = await ethers.getContractFactory("AuraVeritas_Implementation_v1");
    const implementationV1 = await V1_Factory.deploy();
    await implementationV1.waitForDeployment();
    console.log("✅ V1 Implementation deployed to:", await implementationV1.getAddress());

    // Deploy the Proxy
    const gnosisSafeAddress = "0x07769243d608fc7bee30c935600daa73502c90f6";
    const Proxy_Factory = await ethers.getContractFactory("AuraVeritas_Proxy");
    const proxy = await Proxy_Factory.deploy(await implementationV1.getAddress(), gnosisSafeAddress, "0x");
    await proxy.waitForDeployment();
    console.log("✅ VRT Proxy (Token Address) deployed to:", await proxy.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});