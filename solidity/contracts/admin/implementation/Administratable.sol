pragma solidity ^0.5.0;

import "../interface/admin-interface.sol";
import "../../libraries/SafeMath.sol";

contract Administratable is admin {
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

  constructor () public {
    admins[msg.sender] = true;
    superAdmins[msg.sender] = true;
    processedAdmin[msg.sender] = true;
    processedSuperAdmin[msg.sender] = true;
    _owner = msg.sender;
  }


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

   /**
  * @dev Event to show ownership has been transferred
  * @param previousOwner representing the address of the previous owner
  * @param newOwner representing the address of the new owner
  */
  event OwnershipTransferred(address previousOwner, address newOwner);

  /**
  * @dev The constructor sets the original owner of the contract to the sender account.
  */
  function ownable(address newowner) public onlyOwner {
          setOwner(newowner);
  }

  /**
  * @dev Throws if called by any account other than the owner.
  */
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
        return (owner() == _sender_address);
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner(), newOwner);
    setOwner(newOwner);
  }

    // Owner of the contract
  address private _owner;

  /**
   * @dev Tells the address of the owner
   * @return the address of the owner
   */
  function owner() public view returns (address) {
    return _owner;
  }

  /**
   * @dev Sets a new owner address
   */
  function setOwner(address newOwner) internal {
    _owner = newOwner;
  }

}
