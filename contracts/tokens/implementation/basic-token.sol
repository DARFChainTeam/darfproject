pragma solidity ^ 0.5.0;
import "../interface/token-interface.sol";
import "../../receiver/receiver.sol";
import "../../libraries/SafeMath.sol";
//import "../../libraries/Modifiers.sol";

//TODO test to see if contract owner can change the amount of total supply
contract basic is tokenInterface {
  using SafeMath for uint256;
  string internal _symbol;
  string internal _name;
  uint8 internal _decimals;
  uint256 internal _totalSupply;
  address internal _owner;
  mapping(address => uint256) internal _balances;

  modifier onlyOwner(address _sender_address) {
      require(_owner == _sender_address);
      _;

        }

    function basic(string memory symbol, string memory name, uint8 decimals, uint256 totalSupply) public {
        _symbol = symbol;
        _name = name;
        _decimals = decimals;
        _owner = msg.sender;
        _balances[_owner] = totalSupply;
        _totalSupply = totalSupply;
    }
    function get_address() public onlyOwner(msg.sender) returns (address) {
        return address(this);

    }
    function balanceOf(address addr) public view onlyOwner(msg.sender) returns(uint256) {

        return _balances[addr];

    }
    function getOwner() public onlyOwner(msg.sender) returns(address) {

        return _owner;

    }
    function totalSupply() public view onlyOwner(msg.sender) returns(uint256) {

        return _totalSupply;

    }
    function transfer(address sender,address receiver, uint256 amount, bytes memory data) public onlyOwner(msg.sender) returns(bool) {
     if(balanceOf(sender) < amount)
        {
            revert();
        }
       else if (receiver == address(0x0))
        {
            revert();
        }
        else if(receiver==address(0))
        {
            revert();
        }
        else
        {
            //subtrack the amount of tokens from sender

            _balances[sender] = _balances[sender].sub(amount);

            //Add those tokens to reciever
            _balances[receiver] = _balances[receiver].add(amount);

            //If reciever is a contract ...
            if (isContract(receiver)) {
                Receiver Receiverontract = Receiver(receiver);
                //Invoke the call back function on the reciever contract
                Receiverontract.tokenFallback(sender, amount, data);
            }
            return true;
        }
    }




    function transfer(address sender,address receiver, uint256 amount) public onlyOwner(msg.sender) returns(bool) {

          bytes memory empty;
          //use ERC223 transfer function
          bool gotTransfered = transfer(sender,receiver, amount, empty);
          if (gotTransfered)
          return true;
          else
          return false;

    }

    function mint(address tokenAddress,address receiver, uint256 amount) public onlyOwner(msg.sender) returns(bool)
    {
        transfer(tokenAddress,receiver, amount);
    }

    function burn(address owner,uint256 amount) public onlyOwner(msg.sender) returns(bool) {


        //Safty check : token owner cannot burn more than the amount currently exists in their address

        if(_balances[owner] < amount)
        {
            revert();
        }
        else
        {
            //burn operation :
            _balances[owner] = _balances[owner].sub(amount);
            _totalSupply = _totalSupply.sub(amount);
            return true;
        }
    }


    //private functions
    function isContract(address addr) private view returns(bool) {
        uint length;
        assembly {
            //retrieves the size of the code on target address
            length: = extcodesize(addr)
        }
        return (length > 0);
    }


}
