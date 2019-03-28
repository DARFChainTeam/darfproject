pragma solidity ^0.5.0;
import "./interface/sale-interface.sol";
import "./implementation/sellANG_ETH.sol";

contract sale is sellANG_ETH {
    saleInterface private _sale;

     /* constructor() public
    {
      _sale = new sellANG_ETH();
    } */

     function ()  payable external
    {
        _sale = new sellANG_ETH();
        _sale.sellANGETH(msg.sender, msg.value);
    } 

    /* function sell_discount (bytes32 pass_word) payable external
    {
        _sale.sell_discount(msg.sender, msg.value, pass_word);
    } */
}
