token = artifacts.require("./tokens/token.sol");


module.exports = async deployer => {
  var accounts =  await web3.eth.getAccounts();
  var owner = accounts[0];
  console.log("Token owner: ",owner);
  await deployer.deploy(token,"Angel","ANG",18,{from: owner})
  console.log("ANG token address:" + token.address);
}
