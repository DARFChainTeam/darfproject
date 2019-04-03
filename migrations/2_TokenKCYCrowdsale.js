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

var administratable = artifacts.require("./admin/implementation/Administratable.sol");
var external_storage = artifacts.require("./admin/implementation/ExternalStorage.sol");
var Basic_KYC = artifacts.require("./KYC/implementation/Basic_KYC.sol");
var sale = artifacts.require("./tokensale/sellANG_ETH.sol");
var project = artifacts.require("./scruminvest/project.sol");
var userstory = artifacts.require("./scruminvest/userstory.sol")
var token = artifacts.require("./tokens/token.sol");


module.exports = async deployer => {
  var accounts =  await web3.eth.getAccounts();
  var owner = accounts[0];
  console.log("Token owner: ",owner);

  await deployer.deploy(administratable,{from: owner});
  await deployer.deploy(external_storage,{from: owner});
  await deployer.deploy(Basic_KYC,{from: owner});
  await deployer.deploy(sale,{from: owner});
  await deployer.deploy(project,{from: owner});
  await deployer.deploy(userstory,{from: owner});
  await deployer.deploy(token,"Angel","ANG",18,{from: owner});

  //console.log(external_storage);
  //let result = await external_storage.methods.setAddressValue("admin/implementation/basic-ExternalStorage",external_storage.address).call.request({from:owner});
  console.log("Administratable:" + administratable.address);
  console.log("External Storage:" + external_storage.address);
  console.log("KYC Basic:" + Basic_KYC.address);
  console.log("ANG token address:" + token.address);
}
