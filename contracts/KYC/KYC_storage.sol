pragma solidity ^0.4.24;

library  KYC_storage {

    struct Investor {
        uint total_ether;
        uint ANGs;
        int KYC_level;
      }

      mapping (address => Investor) public _investors;

}
