pragma solidity ^0.4.24;
import "./interface/admin-interface.sol";
import "./implementation/basic-admin.sol";
import "../tokens/token.sol";
import "./admin_storage.sol";


  contract admin is simpleAdmin{

    function setAdmin(address _admin_address, bool _admin_state) OnlyOwner(msg.sender) {

      admin_Storage._admins.push[_admin_address].active = _admin_state;
    }

      /*
       contract A {
    uint public target;
    function setTarget(uint _target) public {
        target = _target;
    }
}

contract B {
    A a = Test(0x123abc...);  // address of deployed A
    function editA() public {
        a.setTarget(1);
    }
}
*/


    function change_conditions( uint new_ANG_tokens_rate,
                            uint new_ANG_percent,
                            address  new_KYC_address,
                            address  new_token_address,
                            address new_beneficiar,
                            address  new_owner ) public OnlyOwner(msg.sender) {

        if (new_ANG_tokens_rate > 0 ) ANG_tokens_rate = new_ANG_tokens_rate;
        if (new_ANG_percent > 0 ) ANG_percent = new_ANG_percent;
        if (new_KYC_address > 0) KYC_address = new_KYC_address;
        if (new_token_address > 0) token_address = new_token_address;
        if (new_owner > 0) _owner = new_owner;
        if (new_beneficiar > 0) beneficiar = new_beneficiar;

        }




    function change_discount (uint new_discount_word, uint new_discount)  OnlyOwner(msg.sender) {
          if (new_discount_word > 0) discount_word = new_discount_word;
          if (new_discount > 0) discount_size =  new_discount;
      }
  }