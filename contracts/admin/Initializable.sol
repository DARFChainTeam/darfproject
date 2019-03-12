pragma solidity ^0.5.0;

contract Initializable {
  bool private _initialized;

  modifier isInitializer() {
    require(!_initialized);
    _;
    _initialized = true;
  }
}
