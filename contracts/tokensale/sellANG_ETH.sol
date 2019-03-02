pragma solidity ^0.4.24;
import "./interface/crowdsale-interface.sol";
import "./implementation/basic-crowdsale.sol";
import "../tokens/token.sol";
import "../KYC/KYC.sol";


  contract ExchangeANG_ETH is crowdsaleInterface  {
      address External_Storage_addr;
      uint ANG_tokens_rate_ETH; //1 ETH;
      address public ANGtoken;
      address public owner;
      uint ANG_percent100;
      address public beneficiar;
      address public KYC_address;
      bytes32  discount_word;
      uint discount_size;


      constructor(address _token_address) public {
        owner = msg.sender;
        beneficiar = msg.sender;
        ANGtoken = _token_address;
      }
//setting of valuees-----------------------------------------------------------

//DATA structs------------------------------------------------------------------

    //==============================================================================

        function _setExternalstorageaddr(address Externalstorageaddr ) public onlyAdmins
      {

       External_Storage_addr = Externalstorageaddr;

      }

      function _initExternalStorage(address Externalstorageaddr) public onlyAdmins {

        External_Storage_addr = Externalstorageaddr;
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        ES.setAddressValue("tokensale/ExchangeANG_ETH", address(this));

    }

    function load_conditions_ES () { //when something changes
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        address Projectaddr = ES.getAddressValue("scruminvest/project");
        address ANGtoken =  ES.getAddressValue("ANGtoken");
        uint ANG_tokens_rate = ES.getIntValue("ANGtokensrateETH");
        uint ANG_percent100 = ES.getIntValue("ANGpercent100");

        //project Projectcurrent =  project(Projectaddr);
        //address Projecttokenaddr = Projectcurrent.ProjectsList(ProjectID);
    }



    function () payable public  { //simple buy ANG for Ether
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        address KYCaddr = ES.getAddressValue("KYC/KYC");
        token ANGtoken = token( ES.getAddressValue("ANGtoken");

        KYC = KYC(KYCaddr);
        revert  (KYC.allowed_invest(msg.sender, "ETH") - msg.value < 0);
          uint256 ANG_tokens_amount = msg.value* ANG_tokens_rate_ETH * (100 - ANG_percent100) / 100;
          ANGtoken.transfer(msg.sender,ANG_tokens_amount);
          KYC.register_invest (msg.sender, "ETH", msg.value);
          KYC.register_invest (msg.sender, "ANG", ANG_tokens_amount);
          emit Purchase_ANG (msg.sender, ANG_tokens_amount);

        }


    function sell_discount (bytes32 pass_word) payable public {
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        address KYCaddr = ES.getAddressValue("KYC/KYC");
        token ANGtoken = token( ES.getAddressValue("ANGtoken");
        KYC = KYC(KYCaddr);
        require  (KYC.allowed_invest(msg.sender, "ETH") - msg.value > 0);
          if (pass_word == ES.getBytes32Value("tokensale/discount_word")) {
              uint256 ANG_tokens_amount = msg.value* ANG_tokens_rate_ETH *(100- ANG_percent100)*(ES.getIntvalue("tokensale/discount_size")+100)/10000;
              ANGtoken.transfer(msg.sender,ANG_tokens_amount);
              KYC.register_invest (msg.sender, "ETH", msg.value);
              KYC.register_invest (msg.sender, "ANG", ANG_tokens_amount);
              emit Purchase_ANG (msg.sender, ANG_tokens_amount);
          }
        }



      event Log_no_KYC(address investor);
      //event Change_KYC_level(address investor);
      event Purchase_ANG (address investor, uint256 sum);
  }
