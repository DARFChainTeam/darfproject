pragma solidity ^0.4.24;
import "./interface/admin-interface.sol";
import "./implementation/basic-admin.sol";
import "../tokens/token.sol";

contract admin_Storage{
  /*using SafeMath for uint256;*/
// store all config data here
    struct admin_storage {
        string name_contract ; // filename of contract
        string abi; //abi for contract

    }
    mapping (address => admin_storage) public contracts_adresses;

     constructor(address _token_address) public {
        address owner = msg.sender;
        address beneficiar = msg.sender;
        address token_address = _token_address;
      }
//setting of valuees-----------------------------------------------------------


      struct Admin {
        bool active;
      }

      mapping (address => Admin) public _admins;
    //==============================================================================


}
