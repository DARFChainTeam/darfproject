pragma solidity ^0.4.24;
import "./interface/sale-interface.sol";
import "./implementation/sellANG_ETH.sol";

contract sale is saleInterface {
    saleInterface private _sale;

    function sale(){
        _sale = new sellANG_ETH();

    }

    function () public payable
    {
        _sale.sellANGETH(msg.sender, msg.value);
    }

    function sell_discount(bytes32 pass_word) public payable
    {
        _sale.sell_discount(msg.sender, msg.value, pass_word);
    }
}
