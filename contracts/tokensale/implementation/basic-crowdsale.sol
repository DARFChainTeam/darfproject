pragma solidity ^0.4.24;
import "../../libraries/SafeMath.sol";
import "../interface/crowdsale-interface.sol";
import "../../tokens/token.sol";
import "../../KYC/KYC.sol";
import "../../admin/Ownable.sol";


/*@title Receiver contract Abstract Class
 *@dev this is an abstract class that is the building block of any contract that is supposed to recieve ERC223 token
 */
 //TODO add owner checks
 //TODO add cap
contract simpleCrowdsale is crowdsaleInterface, Ownable, KYC {
  using SafeMath for uint256;

  //State
  uint256 private _startTime;
  uint256 private _endTime;
  address private _wallet;
  address private _owner;
  uint256 private _weiRaised;
  uint256 private _tokenSold;
  uint256 private _cap;
  uint256 private _rate;
  token private _token;
  bool private _finalized = false;




  function simpleCrowdsale(string symbol, string name, uint8 decimals, uint256 totalSupply, uint256 rate) public
  {

      _rate = rate;
      _tokenSold = 0;
      _weiRaised = 0;
      _owner = msg.sender;
   //   _token = new token(symbol, name, decimals); // todo we really need bond token anf sale?
    }


  //check for valid purchase
  function buyTokens(address receiver,uint256 weiAmount) public onlyOwner(msg.sender)  returns(uint256)
  {

      validPurchase();
      if(receiver == 0x0)
      {
          revert();
      }
      else if(receiver == address(0))
      {
          revert();
      }

      else
      {
          //TODO : Add dynamic rate
          _weiRaised = _weiRaised.add(weiAmount);
          // Finding total amount that uas to get transferred
          uint256 rate = getRate();
          uint256 tokens = weiAmount.mul(rate);
          _tokenSold = _tokenSold.add(tokens);
          token.mint(receiver, tokens);
          return tokens;

      }
  }


  function getToken() public onlyOwner returns(address)
  {
    return address(_token);
  }
  function getOwner() public  onlyOwner returns(address)
  {
    return _owner;
  }
  function getAddress() public  onlyOwner returns(address)
  {
    return address(this);
  }

  function getRate() public  onlyOwner returns(uint256)
  {
    return _rate;
  }

    /*
     * @dev this function checks to make sure some basic constraints of a crowdsale is met
     * @returns a boolean value indicating success or failure of this operation
     */

    function validPurchase(address _investor_address, bytes3 currency) internal view returns(bool) {

        return  (InvestorCheck(_investor_address, currency)); //KYC

    }



}
