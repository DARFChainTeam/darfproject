pragma solidity ^0.5.0;

contract storable {
  function getLedgerNameHash() public view returns (bytes32);
  function getStorageNameHash() public view returns (bytes32);
}