//TODO all change!

pragma solidity ^0.4.24;
import "../../libraries/SafeMath.sol";
import "../interface/KYC_interface.sol";
// import "../KYC_storage.sol";
import "../../admin/administratable.sol";
import "../../admin/ExternalStorage.sol";


 //TODO add owner checks


contract basic_KYC is KYC_interface, Administratable {

    address External_Storage_addr;


    // todo  move _investors to External storage
    struct currencies {
        uint256 approved_sum;
        uint256 invested_sum;
    }

     mapping (address => mapping (address => currencies)) public _investors;

  function InvestorCheck(address _investor_address, bytes32 currency)  {
      address currency_adr = keccak256(currency);
      return (_investors[_investor_address][currency_adr].approved_sum - _investors[_investor_address][currency_adr].invested_sum) ;


  }

  function add_KYC(address _investor_address, bytes32 currency, uint256 add_approved_sum)    {
        address currency_adr = keccak256(currency);
        _investors[_investor_address][currency_adr].approved_sum += add_approved_sum;

      // every NY at midnight we need to add approved sums for each currency!
  }


  function register_invest(address _investor_address, bytes32 currency, uint256 add_invested_sum)  {
      address currency_adr = keccak256(currency);

          _investors[_investor_address][currency_adr].invested_sum += add_invested_sum;


    }



       function _initExternalStorage(address Externalstorageaddr) public onlyAdmins {

        External_Storage_addr = Externalstorageaddr;
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        ES.setAddressValue("KYC/implemenation/Basic_KYC", address(this));

    }

}
