pragma solidity ^0.5.0;

interface withdraw_interface {

   function team_withdraw(address userstoryaddr) external;
   function sos_withdraw (address beneficiar, uint256 amount) external;


}
