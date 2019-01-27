pragma solidity ^0.4.18;
import "./interface/admin-interface.sol";
import "./implementation/basic-admin.sol";
import "../tokens/token.sol";

contract admin_Storage{
  /*using SafeMath for uint256;*/
// store all config data here
    struct admin_storage {
        byte32 name_contract ; // filename of contract
        address address_contract;
    }

     constructor(address _token_address) public {
        owner = msg.sender;
        beneficiar = msg.sender;
        token_address = _token_address;
      }
//setting of valuees-----------------------------------------------------------


      struct Admin {
        bool active;
      }

      mapping (address => Admin) public _admins;
    //==============================================================================

    mapping (uint256 => admin_storage) public contracts_adresses;

}
