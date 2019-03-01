pragma solidity ^0.4.24;
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

    function KYC () public {
        _KYC = new basic_KYC ();
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        ES.setAddressValue("KYC/KYC", address(this));

    }

    function  InvestorCheck(address _investor_address, bytes32 currency)
 public
    {
        return _KYC .InvestorCheck( _investor_address,  currency);




    }


    function add_KYC(uint256 ProjectID, address _investor_address, bytes32 currency, uint256 add_approved_sum)   public
    {
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        address Projectaddr =ES.getAddressValue("scruminvest/project");
        project Projectcurrent =  project(Projectaddr);
        address Projecttokenaddr = Projectcurrent.ProjectsList(ProjectID);
        require (msg.sender=Projects[Projecttokenaddr]._DARF_system_address);
            _KYC .add_KYC(_investor_address,  currency, add_approved_sum);



    }

      function register_invest(address _investor_address, bytes32 currency, uint256 add_invested_sum)
      {
        _KYC .register_invest(_investor_address,  currency,  add_invested_sum) ;

      }

       function _init(address Externalstorageaddr) public onlyAdmins {

        External_Storage_addr = Externalstorageaddr;
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        ES.setAddressValue("scruminvest/project", address(this));

    }
}
