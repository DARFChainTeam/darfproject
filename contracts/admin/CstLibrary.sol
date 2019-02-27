pragma solidity ^0.4.24;
import "./ExternalStorage.sol";

library CstLibrary {

  function getTokenName(address _storage) public view returns(bytes32) {
    return ExternalStorage(_storage).getBytes32Value("cstTokenName");
  }

  function setTokenName(address _storage, bytes32 tokenName) public {
    ExternalStorage(_storage).setBytes32Value("cstTokenName", tokenName);
  }

  function getTokenSymbol(address _storage) public view returns(bytes32) {
    return ExternalStorage(_storage).getBytes32Value("cstTokenSymbol");
  }

  function setTokenSymbol(address _storage, bytes32 tokenName) public {
    ExternalStorage(_storage).setBytes32Value("cstTokenSymbol", tokenName);
  }

  function getBuyPrice(address _storage) public view returns(uint256) {
    return ExternalStorage(_storage).getUIntValue("cstBuyPrice");
  }

  function setBuyPrice(address _storage, uint256 value) public {
    ExternalStorage(_storage).setUIntValue("cstBuyPrice", value);
  }

  function getSellPrice(address _storage) public view returns(uint256) {
    return ExternalStorage(_storage).getUIntValue("cstSellPrice");
  }

  function setSellPrice(address _storage, uint256 value) public {
    ExternalStorage(_storage).setUIntValue("cstSellPrice", value);
  }

  function getCirculationCap(address _storage) public view returns(uint256) {
    return ExternalStorage(_storage).getUIntValue("cstCirculationCap");
  }

  function setCirculationCap(address _storage, uint256 value) public {
    ExternalStorage(_storage).setUIntValue("cstCirculationCap", value);
  }

  function getVestingRevocable(address _storage, address beneficiary) public view returns(bool) {
    return ExternalStorage(_storage).getBooleanMapValue("cstVestingRevocable", beneficiary);
  }

  function setVestingReleasedAmount(address _storage, address beneficiary, uint256 value) public {
    ExternalStorage(_storage).setLedgerValue("cstVestingReleasedAmount", beneficiary, value);
  }

  function getVestingReleasedAmount(address _storage, address beneficiary) public view returns(uint256) {
    return ExternalStorage(_storage).getLedgerValue("cstVestingReleasedAmount", beneficiary);
  }

  function getAllowance(address _storage, address account, address spender) public view returns (uint256) {
    return ExternalStorage(_storage).getMultiLedgerValue("cstAllowance", account, spender);
  }

  function setAllowance(address _storage, address account, address spender, uint256 allowance) public {
    ExternalStorage(_storage).setMultiLedgerValue("cstAllowance", account, spender, allowance);
  }





}