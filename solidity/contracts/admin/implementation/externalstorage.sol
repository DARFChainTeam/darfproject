pragma solidity ^0.5.0;

import "../../libraries/SafeMath.sol";
import "../interface/administratable.sol";

contract externalestorage is Administratable {
  using SafeMath for uint256;

  mapping(bytes32 => mapping(address => mapping(address => uint256))) MultiLedgerStorage;
  mapping(bytes32 => uint256) public primaryLedgerCount;
  mapping(bytes32 => mapping(address => bool)) public ledgerPrimaryEntries;
  mapping(bytes32 => mapping(uint256 => address)) public primaryLedgerEntryForIndex;
  mapping(bytes32 => mapping(address => uint256)) public secondaryLedgerCount;
  mapping(bytes32 => mapping(address => mapping(address => bool))) public ledgerSecondaryEntries;
  mapping(bytes32 => mapping(address => mapping(uint256 => address))) public secondaryLedgerEntryForIndex;

  // KYC & investors
  struct currencies {
        uint256 approved_sum;
        uint256 invested_sum;
    }

     mapping (address => mapping (address => currencies)) public _investors;


  function getMultiLedgerValue(string memory record, address primaryAddress, address secondaryAddress) public view returns (uint256) {
    return MultiLedgerStorage[keccak256(abi.encode(record))][primaryAddress][secondaryAddress];
  }

  function setMultiLedgerValue(string memory record, address primaryAddress, address secondaryAddress, uint256 value) public onlyAdmins (msg.sender) {
    bytes32 hash = keccak256(abi.encode(record));
    uint256 primaryLedgerIndex = primaryLedgerCount[hash];
    uint256 secondaryLedgerIndex = secondaryLedgerCount[hash][primaryAddress];
    if (!ledgerSecondaryEntries[hash][primaryAddress][secondaryAddress]) {
      secondaryLedgerEntryForIndex[hash][primaryAddress][secondaryLedgerIndex] = secondaryAddress;
      secondaryLedgerCount[hash][primaryAddress] = secondaryLedgerIndex.add(1);
      ledgerSecondaryEntries[hash][primaryAddress][secondaryAddress] = true;

      if (!ledgerPrimaryEntries[hash][primaryAddress]) {
        primaryLedgerEntryForIndex[hash][primaryLedgerIndex] = primaryAddress;
        primaryLedgerCount[hash] = primaryLedgerIndex.add(1);
        ledgerPrimaryEntries[hash][primaryAddress] = true;
      }
    }

    MultiLedgerStorage[hash][primaryAddress][secondaryAddress] = value;
  }

  mapping(bytes32 => mapping(address => uint256)) LedgerStorage;
  mapping(bytes32 => uint256) public ledgerCount;
  mapping(bytes32 => mapping(address => bool)) public ledgerAccounts;
  mapping(bytes32 => mapping(uint256 => address)) public ledgerEntryForIndex;

  function getLedgerValue(string memory record, address _address) public view returns (uint256) {
    return LedgerStorage[keccak256(abi.encode(record))][_address];
  }

  function getLedgerCount(string memory record) public view returns (uint256) {
    return ledgerCount[keccak256(abi.encode(record))];
  }

  function setLedgerValue(string memory record, address _address, uint256 value) public onlyAdmins (msg.sender) {
    bytes32 hash = keccak256(abi.encode(record));
    if (!ledgerAccounts[hash][_address]) {
      uint256 ledgerIndex = ledgerCount[hash];
      ledgerEntryForIndex[hash][ledgerIndex] = _address;
      ledgerCount[hash] = ledgerIndex.add(1);
      ledgerAccounts[hash][_address] = true;
    }

    LedgerStorage[hash][_address] = value;
  }

  mapping(bytes32 => mapping(address => bool)) BooleanMapStorage;
  mapping(bytes32 => uint256) public booleanMapCount;
  mapping(bytes32 => mapping(address => bool)) public booleanMapAccounts;
  mapping(bytes32 => mapping(uint256 => address)) public booleanMapEntryForIndex;

  function getBooleanMapValue(string memory record, address _address) public view returns (bool) {
    return BooleanMapStorage[keccak256(abi.encode(record))][_address];
  }

  function getBooleanMapCount(string memory record) public view returns (uint256) {
    return booleanMapCount[keccak256(abi.encode(record))];
  }

  function setBooleanMapValue(string memory record, address _address, bool value) public onlyAdmins (msg.sender) {
    bytes32 hash = keccak256(abi.encode(record));
    if (!booleanMapAccounts[hash][_address]) {
      uint256 ledgerIndex = booleanMapCount[hash];
      booleanMapEntryForIndex[hash][ledgerIndex] = _address;
      booleanMapCount[hash] = ledgerIndex.add(1);
      booleanMapAccounts[hash][_address] = true;
    }

    BooleanMapStorage[hash][_address] = value;
  }

  mapping(bytes32 => uint256) UIntStorage;

  function getUIntValue(string memory record) public view returns (uint256) {
    return UIntStorage[keccak256(abi.encode(record))];
  }

  function setUIntValue(string memory record, uint256 value) public onlyAdmins (msg.sender) {
    UIntStorage[keccak256(abi.encode(record))] = value;
  }

  mapping(bytes32 => bytes32) Bytes32Storage;

  function getBytes32Value(string memory record) public view returns (bytes32) {
    return Bytes32Storage[keccak256(abi.encode(record))];
  }

  function setBytes32Value(string memory record, bytes32 value) public onlyAdmins (msg.sender) {
    Bytes32Storage[keccak256(abi.encode(record))] = value;
  }

  mapping(bytes32 => address) AddressStorage;

  function getAddressValue(string memory record) public view returns (address) {
    return AddressStorage[keccak256(abi.encode(record))];
  }

  function setAddressValue(string memory record, address value) public onlyAdmins (msg.sender) {
    AddressStorage[keccak256(abi.encode(record))] = value;
  }

  mapping(bytes32 => bytes) BytesStorage;

  function getBytesValue(string memory record) public view returns (bytes memory) {
    return BytesStorage[keccak256(abi.encode(record))];
  }

  function setBytesValue(string memory record, bytes memory value) public onlyAdmins (msg.sender) {
    BytesStorage[keccak256(abi.encode(record))] = value;
  }

  mapping(bytes32 => bool) BooleanStorage;

  function getBooleanValue(string memory record) public view returns (bool) {
    return BooleanStorage[keccak256(abi.encode(record))];
  }

  function setBooleanValue(string memory record, bool value) public onlyAdmins (msg.sender) {
    BooleanStorage[keccak256(abi.encode(record))] = value;
  }

  mapping(bytes32 => int) IntStorage;

  function getIntValue(string memory record) public view returns (int) {
    return IntStorage[keccak256(abi.encode(record))];
  }

  function setIntValue(string memory record, int value) public onlyAdmins (msg.sender) {
    IntStorage[keccak256(abi.encode(record))] = value;
  }

}
