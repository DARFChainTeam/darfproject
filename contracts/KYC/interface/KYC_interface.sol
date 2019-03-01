pragma solidity ^0.4.24;

interface KYC_interface
{
    // function KYC_interface (address sender,address receiver, uint256 value, bytes data) public returns(bool);
    function InvestorCheck(address _investor_address, bytes32 currency);
    function add_KYC(address _investor_address, bytes32 currency, uint256 add_approved_sum);
    function register_invest(address _investor_address, bytes32 currency, uint256 add_invested_sum);

}
