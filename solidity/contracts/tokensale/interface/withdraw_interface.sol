pragma solidity ^0.5.0;

interface withdraw_interface {

   function team_withdraw(bytes32 userstoryaddr) external payable;
   function sos_withdraw (address beneficiar, uint256 amount) external payable;


}
