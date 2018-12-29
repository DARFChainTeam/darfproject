pragma solidity ^0.4.18;
import "../../tokens/token.sol";

//TODO : Add dynamic rate
interface KYC
{
    function KYC_interface (address sender,address receiver, uint256 value, bytes data) public returns(bool);


}
