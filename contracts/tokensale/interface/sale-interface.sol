pragma solidity ^0.4.24;
//import "../../tokens/token.sol";

interface saleInterface
{
     function sellANGETH(address beneficiar, uint256 summa);
    function sell_discount (address beneficiar, uint256 summa, bytes32 pass_word);


}
