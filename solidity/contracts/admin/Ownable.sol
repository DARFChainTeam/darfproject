pragma solidity ^0.5.0;

import './OwnableStorage.sol';

/**
 * @title Ownable
 * @dev This contract has the owner address providing basic authorization control
 */
contract Ownable is OwnableStorage {
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
}
