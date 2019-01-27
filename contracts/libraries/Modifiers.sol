pragma solidity ^0.4.0;
import "../admin/admin.sol";

library Modifiers {
 //Modification and access right------------------------------------------------


    modifier OnlyAdmin(address _sender_address) {
      require(_admins[_sender_address].active == true);
      _;

        }


    }

