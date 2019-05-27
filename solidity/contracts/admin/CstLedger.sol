pragma solidity ^0.5.0;

import "./interface/administratable.sol";
import "../libraries/SafeMath.sol";

contract ITokenLedger {
  function totalTokens() public view returns (uint256);
  function totalInCirculation() public view returns (uint256);
  function balanceOf(address account) public view returns (uint256);
  function mintTokens(uint256 amount) public;
  function transfer(address sender, address reciever, uint256 amount) public;
  function creditAccount(address account, uint256 amount) public;
  function debitAccount(address account, uint256 amount) public;
  function addAdmin(address admin) public;
  function removeAdmin(address admin) public;
}

contract CstLedger is ITokenLedger, Administratable {

  using SafeMath for uint256;

  uint256 public _totalInCirculation; // warning this does not take into account unvested nor vested-unreleased tokens into consideration
  uint256 public _totalTokens;
  mapping (address => uint256) public _balanceOf;
  uint256 public ledgerCount;
  mapping (uint256 => address) public accountForIndex;
  mapping (address => bool) public accounts;

  function totalTokens() public view returns (uint256) {
    return _totalTokens;
  }

  function totalInCirculation() public view returns (uint256) {
    return _totalInCirculation;
  }

  function balanceOf(address account) public view returns (uint256) {
    return _balanceOf[account];
  }

  function mintTokens(uint256 amount) public onlyAdmins (msg.sender) {
    _totalTokens = _totalTokens.add(amount);
  }

  function makeAccountIterable(address account) internal {
    if (!accounts[account]) {
      accountForIndex[ledgerCount] = account;
      ledgerCount = ledgerCount.add(1);
      accounts[account] = true;
    }
  }

  function transfer(address sender, address recipient, uint256 amount) public onlyAdmins (msg.sender) {
    require(_balanceOf[sender] >= amount);

    _balanceOf[sender] = _balanceOf[sender].sub(amount);
    _balanceOf[recipient] = _balanceOf[recipient].add(amount);
    makeAccountIterable(recipient);
  }

  function creditAccount(address account, uint256 amount) public onlyAdmins (msg.sender) { // decrease asset/increase liability: remove tokens
    require(_balanceOf[account] >= amount);

    _totalInCirculation = _totalInCirculation.sub(amount);
    _balanceOf[account] = _balanceOf[account].sub(amount);
  }

  function debitAccount(address account, uint256 amount) public onlyAdmins (msg.sender) { // increase asset/decrease liability: add tokens
    _totalInCirculation = _totalInCirculation.add(amount);
    _balanceOf[account] = _balanceOf[account].add(amount);
    makeAccountIterable(account);
  }
}