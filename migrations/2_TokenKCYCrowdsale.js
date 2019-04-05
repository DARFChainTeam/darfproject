/* deploy order
1. deploy /admin/implementation/basic-administratable.sol ->get  BasicAdministratableaddr
1.1 administratable Setowner
2. deploy /admin/implementation/basic-ExternalStorage.sol -> get ExternalStorageaddr
3. call address( ExternalStorageaddr)._initAdministratable (address BasicAdministratableaddr)
4. deploy /tokens/token.sol -> get tokenaddr
5.1 call address( tokenaddr)._initAdministratable (address BasicAdministratableaddr)

5.2        call address (ExternalStorageaddr).setAddressValue("ANGtoken",tokenaddr );
5.3        call address (ExternalStorageaddr).setUIntValue("ANGtokensrateETH", 500);
5.4        call address (ExternalStorageaddr).setUIntValue("ANGpercent100", 10);

6. deploy /KYC/implementation/Basic_KYC.sol -> get Basic_KYC_addr
6.1 call  Basic_KYC_addr._initAdministratable (address BasicAdministratableaddr)
6.2 call Basic_KYC_addr._initExternalStorage(  ExternalStorageaddr)
6.3 call address (ExternalStorageaddr).setAddressValue("KYC/implementation/Basic_KYC", Basic_KYC_addr);

7. deploy /tokensale/sale.sol -> get sale_addr
7.1 call  basic-sale_addr._initAdministratable (address BasicAdministratableaddr)
7.2. call sale_addr._initExternalStorage(  ExternalStorageaddr)
7.3        call address (ExternalStorageaddr).setBytes32Value("tokensale/discount_word", "test");
7.4        call address (ExternalStorageaddr).setUIntValue("tokensale/discount_size", 20);
7.5        call address (ExternalStorageaddr).setUIntValue("tokensale/discount_amount", 1000);

*/

var administratable = artifacts.require("./admin/implementation/Administratable.sol");
var external_storage = artifacts.require("./admin/implementation/ExternalStorage.sol");
var Basic_KYC = artifacts.require("./KYC/implementation/Basic_KYC.sol");
var sale = artifacts.require("./tokensale/sellANG_ETH.sol");
var withdraw = artifacts.require("./tokensale/withdraw.sol");

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
  await deployer.deploy(withdraw,{from: owner});
  await deployer.deploy(project,{from: owner});
  await deployer.deploy(userstory,{from: owner});
  await deployer.deploy(token,"Angel","ANG",18,{from: owner});

  //console.log(external_storage);
  //let result = await external_storage.methods.setAddressValue("admin/implementation/basic-ExternalStorage",external_storage.address).call.request({from:owner});
  console.log("Administratable:" + administratable.address);
  console.log("External Storage:" + external_storage.address);
  console.log("KYC Basic:" + Basic_KYC.address);
  console.log("ANG token address:" + token.address);
  console.log("Sale address:" + sale.address);
  console.log("withdraw address:" + withdraw.address);
  console.log("project address:" + project.address);
  console.log("userstory address:" + userstory.address);


  // SimpleStorage.deployed().then(function(instance){return instance.set(4);});

//    3. call address( ExternalStorageaddr)._initAdministratable (address BasicAdministratableaddr)
    console.log("call address( ExternalStorageaddr)._initAdministratable (address BasicAdministratableaddr)");
    await external_storage.deployed().then(function(instance){return instance._initAdministratable(administratable.address),{from: owner}});

//5.1 called address( tokenaddr)._initAdministratable (address BasicAdministratableaddr)

//5.2        call address (ExternalStorageaddr).setAddressValue("ANGtoken",tokenaddr );
//5.3        call address (ExternalStorageaddr).setUIntValue("ANGtokensrateETH", 500);
//5.4        call address (ExternalStorageaddr).setUIntValue("ANGpercent100", 10);
  console.log(" call address( tokenaddr)._initAdministratable (address BasicAdministratableaddr)");
    await token.deployed().then(function(instance){return instance._initAdministratable(administratable.address),{from: owner}});

    console.log(" call address (ExternalStorageaddr).setAddressValue(ANGtoken,tokenaddr );");
    await external_storage.deployed().then(function(instance){return instance.setAddressValue("ANGtoken", token.address),{from: owner}});

    console.log(" call address (ExternalStorageaddr).setUIntValue('ANGtokensrateETH', 500);");
    await external_storage.deployed().then(function(instance){return instance.setUIntValue('ANGtokensrateETH', 500),{from: owner}});

    console.log(" call address (ExternalStorageaddr).setUIntValue('Intestorspayshare100', 5);");
    await external_storage.deployed().then(function(instance){return instance.setUIntValue("Intestorspayshare100", 5),{from: owner}});


// 6.1 call  Basic_KYC_addr._initAdministratable (address BasicAdministratableaddr)
// 6.2 call Basic_KYC_addr._initExternalStorage(  ExternalStorageaddr)
// 6.3 call address (ExternalStorageaddr).setAddressValue("KYC/implementation/Basic_KYC", Basic_KYC_addr);
    console.log("call  Basic_KYC_addr._initAdministratable (address BasicAdministratableaddr)");
    await Basic_KYC.deployed().then(function(instance){return instance._initAdministratable(administratable.address),{from: owner}});

    console.log("call Basic_KYC_addr._initExternalStorage(  ExternalStorageaddr)");
    await Basic_KYC.deployed().then(function(instance){return instance._initExternalStorage(external_storage.address),{from: owner}});

    console.log("call address (ExternalStorageaddr).setAddressValue('KYC/implementation/Basic_KYC', Basic_KYC_addr)");
   await external_storage.deployed().then(function(instance){return instance.setAddressValue("KYC/implementation/Basic_KYC", Basic_KYC.address),{from: owner}});

    /*
 7.1 call  basic-sale_addr._initAdministratable (address BasicAdministratableaddr)
7.2. call sale_addr._initExternalStorage(  ExternalStorageaddr)
7.3        call address (ExternalStorageaddr).setBytes32Value("tokensale/discount_word", "test");
7.4        call address (ExternalStorageaddr).setUIntValue("tokensale/discount_size", 20);
7.5        call address (ExternalStorageaddr).setUIntValue("tokensale/discount_amount", 1000);

*/
       console.log(" call  sale_addr._initAdministratable (address BasicAdministratableaddr)");
    await sale.deployed().then(function(instance){return instance._initAdministratable(administratable.address),{from: owner}});

       console.log(" call sale_addr._initExternalStorage(  ExternalStorageaddr)");
    await sale.deployed().then(function(instance){return instance._initExternalStorage(external_storage.address),{from: owner}});

  console.log(" call address (ExternalStorageaddr).setBytes32Value('tokensale/discount_word', 'test')");
   await external_storage.deployed().then(function(instance){return instance.setBytes32Value("tokensale/discount_word", 'test'),{from: owner}}) ;

  console.log(" call address (ExternalStorageaddr).setUIntValue('tokensale/discount_size', 20)");
   await external_storage.deployed().then(function(instance){return instance.setUIntValue("tokensale/discount_size", 20),{from: owner}}) ;

   console.log(" call address (ExternalStorageaddr).setUIntValue('tokensale/discount_amount', 1000)");
   await external_storage.deployed().then(function(instance){return instance.setUIntValue("tokensale/discount_amount", 1000),{from: owner}}) ;



    //project config
    console.log(" call  project._initAdministratable (address BasicAdministratableaddr)");
    await project.deployed().then(function(instance){return instance._initAdministratable(administratable.address),{from: owner}});

       console.log(" call project._initExternalStorage(  ExternalStorageaddr)");
    await project.deployed().then(function(instance){return instance._initExternalStorage(external_storage.address),{from: owner}});
      console.log(" call address (ExternalStorageaddr).setUIntValue('Projectsspayshare100',5);");
    await external_storage.deployed().then(function(instance){return instance.setUIntValue("Projectsspayshare100", 5),{from: owner}});

    //userstory config
    console.log(" call  userstory._initAdministratable (address BasicAdministratableaddr)");
    await userstory.deployed().then(function(instance){return instance._initAdministratable(administratable.address),{from: owner}});

       console.log(" call userstory._initExternalStorage(  ExternalStorageaddr)");
    await userstory.deployed().then(function(instance){return instance._initExternalStorage(external_storage.address),{from: owner}});

    //withdraw config
     console.log("call  withdraw._initAdministratable (address BasicAdministratableaddr)");
    await withdraw.deployed().then(function(instance){return instance._initAdministratable(administratable.address),{from: owner}});

       console.log("call withdraw._initExternalStorage(  ExternalStorageaddr)");
    await withdraw.deployed().then(function(instance){return instance._initExternalStorage(external_storage.address),{from: owner}});

}
