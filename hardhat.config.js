require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.10",
  networks: {
    gnosis: {
      url: "https://rpc.gnosischain.com/",
      accounts: [process.env.PRIVATE_KEY]
    },
    hardhat: {}
  },
  etherscan: {
    // THIS IS THE CRITICAL CHANGE
    // We provide ONE API key at the top level.
    // Hardhat will now use this single key for all networks it knows about.
    apiKey: process.env.ETHERSCAN_API_KEY, 
    
    customChains: [
      // This section remains the same. It teaches Hardhat about Gnosis.
      {
        network: "gnosis",
        chainId: 100,
        urls: {
          apiURL: "https://api.gnosisscan.io/api",
          browserURL: "https://gnosisscan.io/"
        }
      }
    ]
  }
};