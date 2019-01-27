pragma solidity ^0.4.18;
import "./interface/crowdsale-interface.sol";
import "./implementation/basic-crowdsale.sol";
import "../tokens/token.sol";
import "../libraries/Modifiers.sol";

  contract ANGExchange {

      uint ANG_tokens_rate = 1; //1 ETH;
      address public token_address;
      address public owner;
      uint ANG_percent = 5;
      address public beneficiar;
      address public KYC_address;
      uint public discount_word;
      uint discount_size;


      constructor(address _token_address) public {
        owner = msg.sender;
        beneficiar = msg.sender;
        token_address = _token_address;
      }
//setting of valuees-----------------------------------------------------------

//DATA structs------------------------------------------------------------------
      struct Investor {
        uint total_ether;
        uint ANGs;
        int KYC_level;
      }

      mapping (address => Investor) public _investors;

      struct Admin {
        bool active;
      }

      mapping (address => Admin) public _admins;
    //==============================================================================




    function setAdmin(address _admin_address, bool _admin_state) OnlyOwner(msg.sender) {
      _admins[_admin_address].active = _admin_state;
    }

    function add_KYC(address investor_KYC, int KYC_level) public OnlyAdmin(msg.sender) {
        _investors[investor_KYC].KYC_level = KYC_level;
    }

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
        if (new_owner > 0) owner = new_owner;
        if (new_beneficiar > 0) beneficiar = new_beneficiar;

        }

    event Log_no_KYC(address investor);

    function () payable public  InvestorCheck(msg.sender,msg.value) {
          uint ANG_tokens_amount = msg.value*ANG_tokens_rate/100*(100-ANG_percent);
          _investors[msg.sender].total_ether = msg.value;
          _investors[msg.sender].ANGs = ANG_tokens_amount;
          ANGtoken(token_address).transfer(msg.sender,ANG_tokens_amount);
          emit Log_no_KYC(msg.sender);
        }


    function change_discount (uint new_discount_word, uint new_discount)  OnlyOwner(msg.sender) {
          if (new_discount_word > 0) discount_word = new_discount_word;
          if (new_discount > 0) discount_size =  new_discount;
      }

    function sell_discount (uint pass_word, uint sum, uint amount) payable public InvestorCheck(msg.sender,msg.value) {
          if (pass_word == discount_word) {
              uint ANG_tokens_amount = sum*ANG_tokens_rate*(100-ANG_percent)*(discount_size+100)/10000;
              _investors[msg.sender].total_ether = sum;
              _investors[msg.sender].ANGs = ANG_tokens_amount;
              ANGtoken(token_address).transfer(msg.sender,ANG_tokens_amount);
          }
        }
}
