pragma solidity ^0.5.0;
import "../interface/withdraw_interface.sol";
import '../../admin/administratable.sol';
import '../../scruminvest/userstory.sol';
import '../../scruminvest/project.sol';


contract base_withdraw is withdraw_interface, project, userstory {
     address External_Storage_addr;

    function team_withdraw(address UserStoryAddr) external
    {
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        address currentcontractuserstoryaddr =ES.getAddressValue("scruminvest/userstory");
        userstory userstorycurrent =  userstory(currentcontractuserstoryaddr);
        uint ProjectID = userstorycurrent.UserStories[UserStoryAddr].project_ID;
        address Projectaddr =ES.getAddressValue("scruminvest/project");
        project Projectcontractcurrent =  Project(Projectaddr);
        address Projecttoken = Projectcontractcurrent.ProjectsList(ProjectID);
        require((Projects[Projecttoken].project_owner_address = msg.sender)) ;  // only team lead can withdraw
            token(ES.getAddressValue("ANGtoken")).transfer(address(this), msg.sender, userstorycurrent.UserStories[UserStoryAddr].sum_raised);
    }

   function sos_withdraw (address beneficiar, uint256 amount) onlyOwner external
   {
       ExternalStorage ES = ExternalStorage(External_Storage_addr);
       token(ES.getAddressValue("ANGtoken")).transfer(address(this), beneficiar, amount);
   }


       function _initExternalStorage(address Externalstorageaddr) public onlyAdmins {

        External_Storage_addr = Externalstorageaddr;
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        ES.setAddressValue("tokensale/implementation/base_withdraw", address(this));

    }

     function load_conditions_ES () public  onlyAdmins { //when something changes
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        //Projectaddr = ES.getAddressValue("scruminvest/project");
        //KYC_threshold = ES.getAddressValue('KYC/KYC_threshold');
    }

}
