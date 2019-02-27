pragma solidity ^0.4.24;

interface KYC
{
    // function KYC_interface (address sender,address receiver, uint256 value, bytes data) public returns(bool);
    function InvestorCheck(address _investor_address, uint _value);
    function add_KYC(address investor_KYC, int KYC_level);

}
