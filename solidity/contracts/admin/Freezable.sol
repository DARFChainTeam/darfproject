pragma solidity 0.5.0;

import "./interface/administratable.sol";
import "../libraries/SafeMath.sol";

contract Freezable is Administratable {
  using SafeMath for uint256;

  // zOS requires that the variables are never removed nor order changed
  // Since this is a parent contract, no new variables can be added here
  bool public frozenToken;
  // TODO move this into external storage
  address[] public frozenAccountForIndex;
  mapping (address => bool) public frozenAccount;
  mapping (address => bool) private processedAccount;

  event FrozenFunds(address indexed target, bool frozen);
  event FrozenToken(bool frozen);

  modifier unlessFrozen {
    require(!frozenToken);
    require(!frozenAccount[msg.sender]);
    _;
  }

  function freezeAccount(address target, bool freeze) public onlySuperAdmins (msg.sender) {
    frozenAccount[target] = freeze;
    if (!processedAccount[target]) {
      frozenAccountForIndex.push(target);
      processedAccount[target] = true;
    }
    emit FrozenFunds(target, freeze);
  }

  function freezeToken(bool freeze) public onlySuperAdmins (msg.sender) {
    frozenToken = freeze;
    emit FrozenToken(frozenToken);
  }

  function totalFrozenAccountsMapping() public view returns(uint256) {
    return frozenAccountForIndex.length;
  }

}
