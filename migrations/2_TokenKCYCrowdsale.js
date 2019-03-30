/* deploy order
1. deploy /admin/implementation/basic-administratable.sol ->get  BasicAdministratableaddr
2. deploy /admin/implementation/basic-ExternalStorage.sol -> get ExternalStorageaddr
3. call address( ExternalStorageaddr)._initAdministratable (address BasicAdministratableaddr)
4. deploy /tokens/token.sol -> get tokenaddr
5.1 call address( tokenaddr)._initAdministratable (address BasicAdministratableaddr)

5.2        call address (ExternalStorageaddr).setAddressValue("ANGtoken",tokenaddr );
5.3        call address (ExternalStorageaddr).setUIntValue("ANGtokensrateETH", 500);
5.4        call address (ExternalStorageaddr).setUIntValue("ANGpercent100", 10);

6. deploy /KYC/implementation/Basic_KYC.sol -> get Basic_KYC_addr
8.1 call  Basic_KYC_addr._initAdministratable (address BasicAdministratableaddr)
8.2 call Basic_KYC_addr._initExternalStorage(  ExternalStorageaddr)
8.3 call address (ExternalStorageaddr).setAddressValue("KYC/implementation/Basic_KYC", Basic_KYC_addr);

7. deploy /tokensale/sale.sol -> get sale_addr
8.1 call  basic-sale_addr._initAdministratable (address BasicAdministratableaddr)
8.2. call sale_addr._initExternalStorage(  ExternalStorageaddr)
8.3        call address (ExternalStorageaddr).setBytes32Value("tokensale/discount_word", "test");
8.4        call address (ExternalStorageaddr).setUIntValue("tokensale/discount_size", 20);
8.5        call address (ExternalStorageaddr).setUIntValue("tokensale/discount_amount", 1000);

*/
//basic = artifacts.require("./tokens/implementation/basic-token.sol");
//tokenInterface = artifacts.require("./tokens/interface/token-interface.sol");

//mintable = artifacts.require("./tokens/implementation/mintable-token.sol");
var administratable = artifacts.require("./admin/implementation/Administratable.sol");
var external_storage = artifacts.require("./admin/interface/ExternalStorage.sol");
var token = artifacts.require("./tokens/token.sol");

//KYC = artifacts.require("./KYC/KYC.sol");
// var sale = artifacts.require("./tokensale/sale.sol");


module.exports = async deployer => {
  var accounts =  await web3.eth.getAccounts();
  var owner = accounts[0];
  console.log("Token owner: ",owner);

  await deployer.deploy(administratable,{from: owner});
  await deployer.deploy(external_storage,{from: owner});
  //external_storage set address Administratable
  await external_storage._initAdministratable.call(administratable.address,{from:owner});
  await deployer.deploy(token,"Angel","ANG",18,{from: owner});
  //await deployer.deploy(sale,{from: owner, gas: 672197500});
  //console.log("Sale tokens address:"+sale.address);
  console.log("Administratable:" + administratable.address);
  console.log("External Storage:" + external_storage.address);
  console.log("ANG token address:" + token.address);
}
