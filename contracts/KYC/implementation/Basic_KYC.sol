//TODO all change!

pragma solidity ^0.4.18;
import "../../libraries/SafeMath.sol";
import "../interface/KYC_interface.sol";
import "../KYC_storage.sol";
import "../../admin/admin.sol";
//import "../../tokens/token.sol";

/*@title Receiver contract Abstract Class
 *@dev this is an abstract class that is the building block of any contract that is supposed to recieve ERC223 token
 */
 //TODO add owner checks
 //TODO add cap
contract basic_KYC is KYC {
  modifier OnlyAdmin (address _sender_address) {
      require(admin_Storage._admins[_sender_address].active);
      _;

        }


  function InvestorCheck(address _investor_address, uint _value) {
      return ((KYC_storage._investors[_investor_address].KYC_level == 0 && _value < 1*(1 ether))
      || KYC_storage._investors[_investor_address].KYC_level > 0); // todo don't work this?

  }

  function add_KYC(address investor_KYC, int KYC_level) public OnlyAdmin (msg.sender) {
        KYC_storage._investors.push[investor_KYC].KYC_level = KYC_level;
  }
  function register_purchase(address investor, uint256 sum_ether, uint256 sum_ANG) public OnlyAdmin (msg.sender) {
      if (InvestorCheck (investor,sum_ether)) {
        KYC_storage._investors.push[investor].total_ether++  = sum_ether;
        KYC_storage._investors.push[investor].ANGs++  = sum_ANG;
      }
      else{
          revert;
      }
    }

event Log_no_KYC(address investor);
event Change_KYC_level(address investor);
event Purchase_ANG (address investor);


}
