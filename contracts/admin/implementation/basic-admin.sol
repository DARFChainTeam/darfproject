pragma solidity ^0.5.0;
import "../../libraries/SafeMath.sol";
import "../interface/admin-interface.sol";
import "../../tokens/token.sol";
import "../Ownable.sol";

/*@title Receiver contract Abstract Class
 *@dev this is an abstract class that is the building block of any contract that is supposed to recieve ERC223 token
 */
 //TODO add owner checks
 //TODO add cap
contract simpleAdmin is adminInterface, Ownable {
    uint ANG_tokens_rate = 1 ; //1 ETH
      address public token_address;
      address public _owner;
      uint ANG_percent = 5;
      address public beneficiar;
      address public KYC_address;
      uint public discount_word;
      uint discount_size;

}
