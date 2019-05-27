pragma solidity ^0.5.0;

//import "../Ownable.sol";

//import "../interface/administratable.sol";
//import "../../libraries/SafeMath.sol";
// import "./externalstorage.sol";

contract  admin  {


  function checkAdmin (address msgSender) public returns (bool);

  function checkSuperAdmin (address msgSender) public returns (bool);

  function check_owner (address msgSender) public returns(bool);


}