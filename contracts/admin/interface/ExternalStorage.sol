pragma solidity ^0.5.0;

import "../administratable.sol";

contract  ExternalStorage is Administratable {
   function getMultiLedgerValue(string memory record, address primaryAddress, address secondaryAddress) public view returns (uint256) ;

  function setMultiLedgerValue(string memory record, address primaryAddress, address secondaryAddress, uint256 value) public  ;

  function getLedgerValue(string memory record, address _address) public view returns (uint256) ;

  function getLedgerCount(string memory record) public view returns (uint256) ;
  
  function setLedgerValue(string memory record, address _address, uint256 value) public  ;

  
  function getBooleanMapValue(string memory record, address _address) public view returns (bool) ; 

  function getBooleanMapCount(string memory record) public view returns (uint256) ;

  function setBooleanMapValue(string memory record, address _address, bool value) public  ;

  
  function getUIntValue(string memory record) public view returns (uint256) ;

  function setUIntValue(string memory record, uint256 value) public ;


  function getBytes32Value(string memory record) public view returns (bytes32) ;

  function setBytes32Value(string memory record, bytes32 value) public  ;

    function getAddressValue(string memory record) public view returns (address) ;

  function setAddressValue(string memory record, address value) public  ;

  function getBytesValue(string memory record) public view returns (bytes memory) ;

  function setBytesValue(string memory record, bytes memory value) public  ;

    function getBooleanValue(string memory record) public view returns (bool) ;

  function setBooleanValue(string memory record, bool value) public  ;


  function getIntValue(string memory record) public view returns (int) ;

  function setIntValue(string memory record, int value) public  ;

}
