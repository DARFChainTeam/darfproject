pragma solidity ^0.5.0;
import "../interface/withdraw_interface.sol";
import '../../admin/administratable.sol';
import '../../scruminvest/userstory.sol';
import '../../scruminvest/project.sol';


contract base_withdraw is withdraw_interface, project, userstory {
     address External_Storage_addr;

    function team_withdraw(bytes32 UserStoryAddr) external
    {
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        address currentcontractuserstoryaddr =ES.getAddressValue("scruminvest/userstory");
        userstory userstorycurrent =  userstory(currentcontractuserstoryaddr);

        ( uint256  project_ID,
          uint256   User_story_number,
          bytes32   DFS_Hash,
          bytes4   DFS_type,
          uint256  Story_Amount_ANG,
          uint256   Story_Amount_Tokens,
          uint256  start_date,
          uint256  duration,
          uint256   sum_raised,
          uint256  sum_accepted,
          uint256  Ask_end_from_project,
          uint256  finished  ) = userstorycurrent.UserStories(UserStoryAddr);

        address  Projectaddr =ES.getAddressValue("scruminvest/project");
        project Projectcontractcurrent =  project(Projectaddr);
        address   ProjecttokenAddr = Projectcontractcurrent.ProjectList(project_ID);
        (uint256   project_ID_pr,
        address  project_owner_address,
        address   _DARF_system_address,
        bytes32  DFS_Project_describe,
        bytes4   DFS_type_pr) = Projectcontractcurrent.Projects(ProjecttokenAddr);
        require((project_owner_address == msg.sender)) ;  // only team lead can withdraw
            token(ES.getAddressValue("ANGtoken")).transfer(address(this), msg.sender, sum_raised);
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
