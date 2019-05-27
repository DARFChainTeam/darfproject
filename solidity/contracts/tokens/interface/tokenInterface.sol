pragma solidity ^0.5.0;
interface tokenInterface{

    function balanceOf(address addr) external view returns(uint256);
    function totalSupply() external view returns(uint256);
    function getOwner() external returns(address);
    function transfer(address sender,address receiver, uint256 amount, bytes32  data) external returns(bool);
    function transfer(address sender,address receiver, uint256 amount) external returns(bool);
    function mint(address tokenAddress,address receiver, uint256 amount) external returns(bool);
    function burn(address owner,uint256 amount) external returns(bool);
    function get_address() external returns (address) ;
    function mintable(string calldata symbol, string calldata name, uint8 decimals) external;

}
