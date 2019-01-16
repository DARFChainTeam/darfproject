pragma solidity ^0.4.0;

library Modifiers {
 //Modification and access right------------------------------------------------
    modifier onlyOwner(address _sender_address) {
      require(owner == _sender_address);
      _;

        }

    modifier OnlyAdmin(address _sender_address) {
      require(_admins[_sender_address].active == true);
      _;

        }


    }

