pragma solidity ^0.5.0;
import "./interface/KYC_interface.sol";
import "./implementation/Basic_KYC.sol";
import "../tokens/token.sol";
//import '../admin/administratable.sol';
import "../scruminvest/project.sol";



contract KYC is project {

    //==============================================================================
    //Modification and access right------------------------------------------------

    address External_Storage_addr;

    KYC_interface private _KYC;
    uint256 KYC_threshold = 2 ether;
    address Project_Addr;

    function kyc () public onlyAdmins {
        _KYC = new basic_KYC ();
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        ES.setAddressValue("KYC/KYC", address(this));

    }
    function load_conditions_ES () public onlyAdmins { //when something changes
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        Project_Addr = ES.getAddressValue("scruminvest/project");
       //
    }
    function  allowed_invest (address _investor_address, bytes32 currency)
 public
    {
        return _KYC.InvestorCheck( _investor_address,  currency);




    }


    function add_KYC( address _investor_address, bytes32 currency, uint256 add_approved_sum) onlyAdmins public
    {

            _KYC.add_KYC(_investor_address,  currency, add_approved_sum);



    }

      function register_invest(address _investor_address, bytes32 currency, uint256 add_invested_sum) public
      {
        _KYC.register_invest(_investor_address,  currency,  add_invested_sum) ;

      }

       function _initExternalStorage(address Externalstorageaddr) public onlyAdmins {

        External_Storage_addr = Externalstorageaddr;
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        ES.setAddressValue("KYC/KYC", address(this));
        Project_Addr = ES.getAddressValue("scruminvest/project");


    }
}
