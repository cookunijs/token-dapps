var DeployToken = artifacts.require("./DeployToken.sol");

module.exports = function(deployer) {
  deployer.deploy(DeployToken);
};
