token = artifacts.require("./tokens/token.sol");
sale = artifacts.require("./tokensale/sale.sol");


module.exports = async deployer => {
  var accounts =  await web3.eth.getAccounts();
  var owner = accounts[0];
  console.log("Token owner: ",owner);
  await deployer.deploy(token,"Angel","ANG",18,{from: owner});
  await deployer.deploy(sale,{from: owner});
  console.log("Sale tokens address:"+sale.address);
//  console.log("ANG token address:" + token.address);
}
