pragma solidity ^0.5.0;

import "../Ownable.sol";
import "../../libraries/SafeMath.sol";
// import "./ExternalStorage.sol";

contract Administratable is Ownable {

  address Basic_Administratable_addr;
  address  External_Storage_addr;
  Administratable BA_;

  modifier onlyAdmins  (address msgSender)  {
    if (checkAdmin(msgSender)) revert();
    _;
  }

  modifier onlySuperAdmins (address msgSender) {
    if (checkSuperAdmin(msgSender)) revert();
    _;
  }

  function checkAdmin (address msgSender) internal returns (bool)
  {
      return BA_.checkAdmin(msgSender);
  }

  function checkSuperAdmin (address msgSender) internal returns (bool)
  {
    return BA_.checkSuperAdmin(msgSender);

  }

/*

         function _initExternalStorage(address Externalstorageaddr) public onlyAdmins (msg.sender) {

        External_Storage_addr = Externalstorageaddr;
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        ES.setAddressValue("admin/interface/administratable", address(this));
        load_conditions_ES();


    }

     function load_conditions_ES () public onlyAdmins (msg.sender) { //when something changes
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        //Projectaddr = ES.getAddressValue("scruminvest/project");
        Basic_Administratable_addr = ES.getAddressValue('admin/implementation/basic-administratable');
       BA_ = Administratable(Basic_Administratable_addr);
     }
*/

   function _initAdministratable (address BasicAdministratableaddr) public onlyOwner { // deployed address of admin/implementation/basic-administratable.sol

          BA_ = Administratable(BasicAdministratableaddr);
     }
}