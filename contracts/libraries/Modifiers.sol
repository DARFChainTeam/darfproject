pragma solidity ^0.4.0;

library Modifiers {
 //Modification and access right------------------------------------------------
    modifier OnlyOwner(address _sender_address) {
      require(owner == _sender_address);
      _;

        }

    modifier OnlyAdmin(address _sender_address) {
      require(_admins[_sender_address].active == true);
      _;

        }

    modifier InvestorCheck(address _investor_address, uint _value) {
      require((_investors[_investor_address].KYC_level == 0 && _value < 1*(1 ether)) || _investors[_investor_address].KYC_level > 0);
      _;

    }
}
