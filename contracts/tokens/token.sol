pragma solidity ^0.5.0;
import "./interface/token-interface.sol";
import "./implementation/basic-token.sol";
import "./implementation/mintable-token.sol";
import "../admin/ExternalStorage.sol";
import "../admin/administratable.sol";

// contracts/libraries/Modifiers.sol

//Todo Create a Hybrid TOken
/*
 * @title Basic token
 * @dev This ERC223 token is the most basic of them all ; the total amount of
    tokens are first created and stored in the contract's owner address.
 * @dev The total supply is created first ( it is capped ) and sent to different
    addresses during ICO
 */

 //TODO MAke sure burn and other are called through the parent.
contract token is Mintable {
    tokenInterface private _token;
    address private _owner;
    bool private _finalized = false;
    address  External_Storage_addr;


    function Token(string memory symbol, string memory name, uint8 decimals ) public
    {
      _owner = msg.sender;
      _token= new Mintable();
      _token.mintable(symbol,name,decimals) ;

    }
    function get_address() public returns (address)
    {
      return _token.get_address();
    }

    /*
     * @dev get balance of a tokens address
     * @params an address representing target wallet
     * @return A uint256 representing an address balance
     */
    function balanceOf(address addr) public view returns(uint256)
    {
      uint256 result = _token.balanceOf(addr);
      return result;
    }

    /*
     * @dev get total amount of tokens created
     * @return A uint256 representing the number oif tokens created.
     */
    function totalSupply() public view returns(uint256)
    {
      uint256 result = _token.totalSupply();
      return result;
    }

    /*
     * @dev get the tokens creator address
     * @return token creator's (owner) address
     */
    function getChildOwner() public returns(address)
    {
      address result = _token.getOwner();
      emit GetOwner(result);
      return result;
    }
    function getOwner() public returns(address)
    {
      return _owner;
    }
    /*
     * @dev transfer function that is called when user or a contract wants to transfer tokens.
     * @params to is the address tokens are being transferred to
     * @params amount is the amount of tokens being transfered
     * @params data is of type bytes that represents the message being sent
     * @return A uint8 representing token's decimals
     */
    function transfer(address sender, address receiver, uint256 amount, bytes32 data) external returns(bool)
    {
      bool result=_token.transfer(sender,receiver,amount,data);
      if(result)
      {
        emit Transfer(msg.sender,receiver,amount ,data);
      }
      return result;
    }

    /*
     * @dev transfer function that is called when user or a contract wants to transfer tokens.
     * @dev it is identical to ERC20 Standard's transfer function
     * @params to is the address tokens are being transferred to
     * @params amount is the amount of tokens being transfered
     * @return A uint8 representing token's decimals
     */
    function transfer(address receiver, uint256 amount) public returns(bool)
    {
      bytes32 empty;
      bool result = _token.transfer(msg.sender,receiver,amount);
      if(result)
      {
        emit Transfer( msg.sender,receiver,amount,empty);
      }
      return result;
    }


    function mint(address receiver, uint256 amount) public onlyOwnerEx (msg.sender) returns(bool)
    {

        bool result = _token.mint(address(this),receiver,amount);
        if(result)
        {
          emit Mint(receiver, amount);
        }
        return result;

    }



    /*
     * @dev this is the function that is called when tokens are being burnt
     * @params amount is of type uint 256 representingnumber of tokens being burnt
     * @return a boolean alue indication success or failure of the operation
     */
    function burn(uint256 amount) public returns(bool)
    {
      bool result = _token.burn(msg.sender,amount);
      if(result)
      {
        emit Burn(msg.sender, amount);
      }
      return result;
    }


    //Events
   // event TotalSupply(uint256 totalSupply);
    event BalanceOf(address addr, uint256 balance);
    event Burn(address indexed receiver, uint256 amount);
    event Transfer(address indexed sender, address indexed receiver, uint256 amount, bytes32 data);
    event GetOwner(address indexed owner);
    event Mint(address indexed receiver, uint256 amount);




}
