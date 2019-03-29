//basic = artifacts.require("./tokens/implementation/basic-token.sol");
//tokenInterface = artifacts.require("./tokens/interface/token-interface.sol");

//mintable = artifacts.require("./tokens/implementation/mintable-token.sol");
token = artifacts.require("./tokens/token.sol");

//KYC = artifacts.require("./KYC/KYC.sol");
sale = artifacts.require("./tokensale/sale.sol");


module.exports = async deployer => {
  var accounts =  await web3.eth.getAccounts();
  var owner = accounts[0];
  console.log("Token owner: ",owner);
  //await deployer.deploy(basic,{from: owner});

  //deployer.link(basic, mintable);
  //await deployer.deploy(mintable,{from: owner});
  //deployer.link(mintable, token);
  await deployer.deploy(token,"Angel","ANG",18,{from: owner});

  await deployer.deploy(sale,{from: owner, gas: 672197500});
  console.log("Sale tokens address:"+sale.address);
//  console.log("ANG token address:" + token.address);
}
