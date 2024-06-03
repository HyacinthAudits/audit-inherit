require("@nomiclabs/hardhat-waffle");
require("hardhat-gas-reporter");

module.exports = {
    solidity: {
        version: "0.8.22",
        settings: {
            optimizer: {
                enabled: true,
                runs: 1000,
            },
        },
    },
    gasReporter: {
        currency: "USD",
        gasPrice: 100,
    },
};
