pragma solidity ^0.4.24;
import  "../interface/withdraw_interface.sol";
import  '../../scruminvest/project.sol';

contract base_withdraw is withdraw_interface, project {
     address External_Storage_addr;

    function team_withdraw(address userstoryaddr)
    {

        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        address Projectaddr =ES.getAddressValue("scruminvest/project");
        project Projectcurrent =  Project(Projectaddr);
        address Projecttoken = Projectcurrent.ProjectsList(ProjectID);
        require((Projects[Projecttoken].project_owner_address = msg.sender)) ;
            token(ES.getAddressValue("ANGtoken")).transfer(address(this), msg.sender, UserStories[UserStoryAddr].sum_raised);
    }

   function sos_withdraw (address beneficiar, uint256 amount) onlyOwner
   {
       ExternalStorage ES = ExternalStorage(External_Storage_addr);
       token(ES.getAddressValue("ANGtoken")).transfer(address(this), beneficiar, amount);
   }


       function _initExternalStorage(address Externalstorageaddr) public onlyAdmins {

        External_Storage_addr = Externalstorageaddr;
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        ES.setAddressValue("tokensale/implementation/base_withdraw", address(this));

    }

     function load_conditions_ES () onlyAdmins { //when something changes
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        //Projectaddr = ES.getAddressValue("scruminvest/project");
        //KYC_threshold = ES.getAddressValue('KYC/KYC_threshold');
    }

}
