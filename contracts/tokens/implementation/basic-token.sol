pragma solidity ^ 0.5.0;
import "../interface/token-interface.sol";
import "../../receiver/receiver.sol";
import "../../libraries/SafeMath.sol";
import  "../../admin/interface/administratable.sol";
//import "../../libraries/Modifiers.sol";

//TODO test to see if contract owner can change the amount of total supply
contract basic is tokenInterface, Administratable  {
  using SafeMath for uint256;
  string internal _symbol;
  string internal _name;
  uint8 internal _decimals;
  uint256 internal _totalSupply;
  address internal _owner;
  mapping(address => uint256) internal _balances;


    function Basic(string memory symbol, string memory name, uint8 decimals, uint256 totalSupply) public {
        _symbol = symbol;
        _name = name;
        _decimals = decimals;
        _owner = msg.sender;
        _balances[_owner] = totalSupply;
        _totalSupply = totalSupply;
    }
    function get_address() public onlyOwnerEx(msg.sender) returns (address) {
        return address(this);

    }
    function balanceOf(address addr) public view  returns(uint256) { //onlyOwnerEx(msg.sender)

        return _balances[addr];

    }
    function getOwner() public onlyOwnerEx(msg.sender) returns(address) {

        return _owner;

    }
    function totalSupply() public view returns(uint256) { //onlyOwnerEx(msg.sender)

        return _totalSupply;

    }
    function transfer(address sender,address receiver, uint256 amount, bytes32  data)   onlyOwnerEx(msg.sender) external returns(bool) {
            return  transferIntnl( sender, receiver,  amount, data) ;

    }



function transferIntnl(address sender,address receiver, uint256 amount, bytes32  data)   onlyOwnerEx(msg.sender) internal returns(bool) {
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


    function transfer(address sender,address receiver, uint256 amount)  onlyOwnerEx(msg.sender) external returns(bool) {

         bytes32 empty;
          //use ERC223 transfer function
          bool gotTransfered = transferIntnl(sender,receiver, amount, empty);
          if (gotTransfered)
          return true;
          else
          return false;

    }

    function mint(address tokenAddress,address receiver, uint256 amount) public onlyOwnerEx(msg.sender) returns(bool)
    {
        bytes32 empty;
        transferIntnl(tokenAddress,receiver, amount,empty );
    }

    function burn(address owner,uint256 amount) public onlyOwnerEx(msg.sender) returns(bool) {


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
