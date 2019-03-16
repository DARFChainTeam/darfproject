pragma solidity ^0.5.0;
/*import "./implementation/basic-token.sol";*/
/*import "./implementation/mintable-token.sol";*/
/*@title Receiver contract Abstract Class
 *@dev this is an abstract class that is the building block of any contract that is supposed to recieve ERC223 token
 */
interface receiverInterface {

    function tokenFallback(address sender,address receiver, uint256 value, bytes calldata data) external returns(bool);
    function tokenFallback(address sender, uint256 value, bytes calldata data) external returns(bool);
    function whitelist(address tokenAddress) external returns(bool) ;
    function blacklist(address tokenAddress) external returns(bool);

}
