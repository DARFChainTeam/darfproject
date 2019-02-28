//TODO all change!

pragma solidity ^0.4.24;
import "../../libraries/SafeMath.sol";
import "../interface/KYC_interface.sol";
// import "../KYC_storage.sol";
import "../../admin/administratable.sol";


 //TODO add owner checks


contract basic_KYC is KYC_interface, Administratable {
/*  modifier OnlyAdmin (address _sender_address) {
      require(admin_Storage._admins[_sender_address].active);
      _;

        }

*/
    struct currencies {
        uint256 approved_sum;
        uint256 invested_sum;
    }


     mapping (address => mapping (bytes3 => currencies)) public _investors;


  function InvestorCheck(address _investor_address, bytes3 currency)  {
      return (_investors[_investor_address][currency].approved_sum - _investors[_investor_address][currency].invested_sum) ;


  }

  function add_KYC(address _investor_address, bytes3 currency, uint256 add_approved_sum)    {
        _investors[_investor_address][currency].approved_sum += add_approved_sum;

      // every NY at midnight we need to add approved sums for each currency!
  }


  function register_invest(address _investor_address, bytes3 currency, uint256 add_invested_sum)  {
      require (InvestorCheck (_investor_address,currency) - add_invested_sum > 0);
          _investors[_investor_address][currency].invested_sum += add_invested_sum;


    }

//event Log_no_KYC(address investor);
//event Change_KYC_level(address investor);
//event Purchase_ANG (address investor);


}
