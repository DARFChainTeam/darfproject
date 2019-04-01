pragma solidity ^0.5.0;
import '../admin/interface/administratable.sol';
import '../scruminvest/interface/userstory_inteface.sol';
import '../scruminvest/interface/project_interface.sol';
import '../admin/interface/ExternalStorage.sol';
import '../tokens/interface/tokenInterface.sol';

contract withdraw is  Administratable { //withdraw_interface


    address External_Storage_addr;
     address Userstory_smart_contr_addr;
     address  Project_smart_contr_addr;
     address  ANGtokenaddr;


    function getUserStoryData(bytes32 UserStoryAddr) internal returns (uint256, uint256)
    {
          userstory_inteface userstorycurrent =  userstory_inteface(Userstory_smart_contr_addr);

        ( uint256  project_ID, //+
          ,//uint256   User_story_number,
          ,//bytes32   DFS_Hash,
          ,//bytes4   DFS_type,
          ,//uint256  Story_Amount_ANG,
          ,//uint256   Story_Amount_Tokens,
          ,//uint256  start_date,
          ,//uint256  duration,
          uint256   sum_raised, //+
          ,//uint256  sum_accepted,
          ,//uint256  Ask_end_from_project,
          uint256  finished  ) = userstorycurrent.give_userstory_data(UserStoryAddr);
        return (project_ID,sum_raised );
    }
    function getProjectOwnerAddress(uint256 project_ID) internal returns (address)
    {
        project_interface Projectcontractcurrent =  project_interface(Project_smart_contr_addr);
        //address   ProjecttokenAddr = Projectcontractcurrent.ProjectList(project_ID);
        (address ProjecttokenAddr,
        ,//uint256   project_ID_pr,
        address  project_owner_address, //+
        ,//address   _DARF_system_address,
        ,//bytes32  DFS_Project_describe,
        bytes4   DFS_type_pr) = Projectcontractcurrent.give_project_data(project_ID);

        return project_owner_address;
    }


    function team_withdraw(bytes32 UserStoryAddr) payable public
    {


        (uint256 project_ID,
        uint256 sum_raised) =  getUserStoryData( UserStoryAddr);

        require((getProjectOwnerAddress(project_ID) == msg.sender)) ;  // only team lead can withdraw
        tokenInterface tokencurrent = tokenInterface(ANGtokenaddr);
        tokencurrent.transfer(address(this), msg.sender, sum_raised);
    }

   function sos_withdraw (address beneficiar, uint256 amount) payable public  onlyOwner
   {

       tokenInterface tokencurrent = tokenInterface(ANGtokenaddr);
       tokencurrent.transfer(address(this), beneficiar, amount);
   }


       function _initExternalStorage(address Externalstorageaddr) public onlyAdmins (msg.sender) {

        External_Storage_addr = Externalstorageaddr;
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        ES.setAddressValue("tokensale/implementation/withdraw", address(this));
        load_conditions_ES;
    }

     function load_conditions_ES () public  onlyAdmins (msg.sender) { //when something changes
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        Userstory_smart_contr_addr =ES.getAddressValue("scruminvest/userstory");
        Project_smart_contr_addr =ES.getAddressValue("scruminvest/project");
        ANGtokenaddr = ES.getAddressValue("ANGtoken");

        //Projectaddr = ES.getAddressValue("scruminvest/project");
        //KYC_threshold = ES.getAddressValue('KYC/KYC_threshold');
    }


}
