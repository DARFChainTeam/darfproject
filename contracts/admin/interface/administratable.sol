pragma solidity ^0.5.0;

import "./admin-interface.sol";

//import "../interface/administratable.sol";
//import "../../libraries/SafeMath.sol";
// import "./ExternalStorage.sol";

contract Administratable is admin {

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

  function checkAdmin (address msgSender) public returns (bool)
  {
      return BA_.checkAdmin(msgSender);
  }

  function checkSuperAdmin (address msgSender) public returns (bool)
  {
    return BA_.checkSuperAdmin(msgSender);

  }

  modifier onlyOwner() {
    require (check_owner (msg.sender));
    _;
  }

  modifier onlyOwnerEx (address _sender_address) {
    require(check_owner(_sender_address));
    _;

      }

    function check_owner (address _sender_address) public returns(bool)
  {
        return BA_.check_owner(_sender_address);
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