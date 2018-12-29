//TODO all change!

pragma solidity ^0.4.18;
import "../../libraries/SafeMath.sol";
import "../interface/KYC_interface.sol";
import "./KYC_storage.sol";
//import "../../tokens/token.sol";

/*@title Receiver contract Abstract Class
 *@dev this is an abstract class that is the building block of any contract that is supposed to recieve ERC223 token
 */
 //TODO add owner checks
 //TODO add cap
contract basic_KYC is KYC_interface {

  modifier InvestorCheck(address _investor_address, uint _value) {
      require((_investors[_investor_address].KYC_level == 0 && _value < 1*(1 ether))
      || _investors[_investor_address].KYC_level > 0);
      _;
  }

event Log_no_KYC(address investor);


}
