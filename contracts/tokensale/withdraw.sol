pragma solidity ^0.5.0;
import "./interface/withdraw_interface.sol";
import "./implementation/base_withdraw.sol";
import '../admin/administratable.sol';


contract withdraw is withdraw_interface, Administratable {

    withdraw_interface private _withdraw;

    function Withdraw() public  {
       _withdraw = new base_withdraw();

    }

    function team_withdraw(bytes32 UserStoryAddr) payable external
    {
        _withdraw.team_withdraw(UserStoryAddr);
    }

    function sos_withdraw (address beneficiar, uint256 amount) payable external onlySuperAdmins
    {
        _withdraw.sos_withdraw (beneficiar, amount) ;
    }
}
