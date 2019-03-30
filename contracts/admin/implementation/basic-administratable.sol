pragma solidity ^0.5.0;

import "../Ownable.sol";
import "../../libraries/SafeMath.sol";

contract Administratable is Ownable {
  using SafeMath for uint256;

  uint256 public totalAdminsMapping;
  uint256 public totalSuperAdminsMapping;
  mapping (uint256 => address) public adminsForIndex;
  mapping (uint256 => address) public superAdminsForIndex;
  mapping (address => bool) public admins;
  mapping (address => bool) public superAdmins;
  mapping (address => bool) processedAdmin;
  mapping (address => bool) processedSuperAdmin;

  event AddAdmin(address indexed admin);
  event RemoveAdmin(address indexed admin);
  event AddSuperAdmin(address indexed admin);
  event RemoveSuperAdmin(address indexed admin);


  modifier onlyAdmins  (address msgSender)  {
    if (checkAdmin(msgSender)) revert();
    _;
  }

  modifier onlySuperAdmins (address msgSender) {
    if (checkSuperAdmin(msgSender)) revert();
    _;
  }


  function checkAdmin (address msgSender) public returns (bool) {

    return ((msgSender != owner() ) && (!superAdmins[msgSender]) && (!admins[msgSender]));

  }

  function checkSuperAdmin (address msgSender) public returns (bool) {

    return ((msgSender != owner() ) && (!admins[msgSender]));

  }


  function addSuperAdmin(address admin) public onlyOwner {
    superAdmins[admin] = true;
    if (!processedSuperAdmin[admin]) {
      processedSuperAdmin[admin] = true;
      superAdminsForIndex[totalSuperAdminsMapping] = admin;
      totalSuperAdminsMapping = totalSuperAdminsMapping.add(1);
    }

    emit AddSuperAdmin(admin);
  }

  function removeSuperAdmin(address admin) public onlyOwner {
    superAdmins[admin] = false;

    emit RemoveSuperAdmin(admin);
  }

  function addAdmin(address admin) public onlySuperAdmins (msg.sender) {
    admins[admin] = true;
    if (!processedAdmin[admin]) {
      processedAdmin[admin] = true;
      adminsForIndex[totalAdminsMapping] = admin;
      totalAdminsMapping = totalAdminsMapping.add(1);
    }

    emit  AddAdmin(admin);
  }

  function removeAdmin(address admin) public onlySuperAdmins (msg.sender) {
    admins[admin] = false;

    emit RemoveAdmin(admin);
  }
}