pragma solidity ^0.5.0;
import "../interface/sale-interface.sol";
//import "./implementation/basic-crowdsale.sol";
import "../../tokens/token.sol";
import "../../KYC/KYC.sol";
import "../../tokens/token.sol";
import "../../admin/ExternalStorage.sol";


  contract sellANG_ETH is saleInterface, KYC  {
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

        function _setExternalstorageaddr(address Externalstorageaddr ) public onlyAdmins
      {

       External_Storage_addr = Externalstorageaddr;

      }

      function _initExternalStorage(address Externalstorageaddr) public onlyAdmins {

        External_Storage_addr = Externalstorageaddr;
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        ES.setAddressValue("tokensale/ExchangeANG_ETH", address(this));

    }

    function load_conditions_ES () public  { //when something changes
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        ANGtoken_addr =  ES.getAddressValue("ANGtoken");
        ANG_tokens_rate_ETH = ES.getIntValue("ANGtokensrateETH");
        ANG_percent100 = ES.getIntValue("ANGpercent100");
        KYC_address = ES.getAddressValue("KYC/KYC");
        discount_word =  ES.getBytes32Value("tokensale/discount_word");
        discount_size100 = ES.getIntvalue("tokensale/discount_size");
        discount_amount =  ES.getUIntvalue("tokensale/discount_amount");
        // project Projectcurrent =  project(Projectaddr);
        //address Projecttokenaddr = Projectcurrent.ProjectsList(ProjectID);
    }



    function sellANGETH(address beneficiar, uint256 summa)  external  { //simple buy ANG for Ether

        token ANGtoken = token( ANGtoken_addr);

        KYC = KYC(KYC_address);
        require  (KYC.allowed_invest(beneficiar, "ETH") - summa > 0);
          uint256 ANG_tokens_amount = summa* ANG_tokens_rate_ETH * (100 - ANG_percent100) / 100;
          ANGtoken.transfer(beneficiar,ANG_tokens_amount);
          KYC.register_invest (beneficiar, "ETH", summa);
          KYC.register_invest (beneficiar, "ANG", ANG_tokens_amount);
          emit Purchase_ANG (beneficiar, ANG_tokens_amount);

        }


    function sell_discount (address beneficiar, uint256 summa, bytes32 pass_word) external  {
        token ANGtoken = token( ANGtoken_addr);
        KYC = KYC(KYC_address);
        require ((discount_amount > summa) && (KYC.allowed_invest(beneficiar, "ETH") - summa > 0) &&  (pass_word == discount_word));

              uint256 ANG_tokens_amount = summa * ANG_tokens_rate_ETH *(100 - ANG_percent100)*(discount_size100 +100)/10000;
              discount_amount -= summa;
              ANGtoken.transfer(beneficiar,ANG_tokens_amount);
              KYC.register_invest (beneficiar, "ETH", summa);
              KYC.register_invest (beneficiar, "ANG", ANG_tokens_amount);
              emit Purchase_ANG (beneficiar, ANG_tokens_amount);

        }



      event Log_no_KYC(address investor);
      //event Change_KYC_level(address investor);
      event Purchase_ANG (address investor, uint256 sum);
  }
