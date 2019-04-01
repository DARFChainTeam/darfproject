pragma solidity ^0.5.0;
//import "../interface/sale-interface.sol";
//import "./implementation/basic-crowdsale.sol";
import "../tokens/interface/tokenInterface.sol";
import "../KYC/interface/KYC_interface.sol";
import "../admin/interface/administratable.sol";
import "../admin/interface/ExternalStorage.sol";


  contract sellANG_ETH is Administratable { //} is token, KYC_interface  { // saleInterface
      address External_Storage_addr;
      uint ANG_tokens_rate_ETH; //1 ETH;
      address public ANGtoken_addr;
      //address public owner;
      uint ANG_percent100;
      //address public beneficiar;
      address public KYC_address;
      bytes32  discount_word;
      uint discount_size100;
      uint256 discount_amount;

/*

      constructor(address _token_address) public {
        owner = beneficiar;
        beneficiar = beneficiar;
        ANGtoken = _token_address;
      }
*/
//setting of valuees-----------------------------------------------------------

//DATA structs------------------------------------------------------------------

    //==============================================================================
//setting of valuees-----------------------------------------------------------

        function _setExternalstorageaddr(address Externalstorageaddr ) public onlyAdmins (msg.sender)
      {

       External_Storage_addr = Externalstorageaddr;

      }

      function _initExternalStorage(address Externalstorageaddr) public onlyAdmins (msg.sender) {

        External_Storage_addr = Externalstorageaddr;
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        ES.setAddressValue("tokensale/ExchangeANG_ETH", address(this));
        load_conditions_ES ();
    }

    function load_conditions_ES () public  { //when something changes
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        ANGtoken_addr =  ES.getAddressValue("ANGtoken");
        ANG_tokens_rate_ETH = ES.getUIntValue("ANGtokensrateETH");
        ANG_percent100 = ES.getUIntValue("ANGpercent100");
        KYC_address = ES.getAddressValue("KYC/implementation/Basic_KYC");
        discount_word =  ES.getBytes32Value("tokensale/discount_word");
        discount_size100 = ES.getUIntValue("tokensale/discount_size");
        discount_amount =  ES.getUIntValue("tokensale/discount_amount");
        // project Projectcurrent =  project(Projectaddr);
        //address Projecttokenaddr = Projectcurrent.ProjectsList(ProjectID);
    }



    function sellANGETH(address beneficiar, uint256 summa)  public payable { //simple buy ANG for Ether

        tokenInterface ANGtoken = tokenInterface ( ANGtoken_addr);

        KYC_interface KYC_ = KYC_interface (KYC_address);
        require  (KYC_.allowed_invest(beneficiar, "ETH") - summa > 0);
          uint256 ANG_tokens_amount = summa* ANG_tokens_rate_ETH * (100 - ANG_percent100) / 100;
          ANGtoken.transfer(address(this), beneficiar,ANG_tokens_amount);
          KYC_.register_invest (beneficiar, "ETH", summa);
          KYC_.register_invest (beneficiar, "ANG", ANG_tokens_amount);
          emit Purchase_ANG (beneficiar, ANG_tokens_amount);

        }


    function sell_discount (address beneficiar, uint256 summa, bytes32 pass_word) public payable  {
        tokenInterface ANGtoken = tokenInterface ( ANGtoken_addr);
        KYC_interface KYC_ = KYC_interface (KYC_address);
        require ((discount_amount > summa) && (KYC_.allowed_invest(beneficiar, "ETH") - summa > 0) &&  (pass_word == discount_word));

              uint256 ANG_tokens_amount = summa * ANG_tokens_rate_ETH *(100 - ANG_percent100)*(discount_size100 +100)/10000;
              discount_amount -= summa;
              ANGtoken.transfer(address(this),beneficiar,ANG_tokens_amount);
              KYC_.register_invest (beneficiar, "ETH", summa);
              KYC_.register_invest (beneficiar, "ANG", ANG_tokens_amount);
              emit Purchase_ANG (beneficiar, ANG_tokens_amount);

        }

      

      event Log_no_KYC(address investor);
      //event Change_KYC_level(address investor);
      event Purchase_ANG (address investor, uint256 sum);
  }
