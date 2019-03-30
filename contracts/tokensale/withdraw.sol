pragma solidity ^0.5.0;
//import "./interface/withdraw_interface.sol";
// import "./implementation/base_withdraw.sol";
import '../admin/interface/administratable.sol';
import '../scruminvest/userstory.sol';
import '../scruminvest/project.sol';

contract withdraw is  Administratable { //withdraw_interface


    /*
        withdraw_interface private _withdraw;

    constructor () public  {
       _withdraw = new base_withdraw();
    }

    function team_withdraw(bytes32 UserStoryAddr) payable public
    {
       _withdraw = new base_withdraw();
       _withdraw.team_withdraw(UserStoryAddr);
    }

    function sos_withdraw (address beneficiar, uint256 amount) payable public onlySuperAdmins (msg.sender)
    {
       _withdraw = new base_withdraw();

        _withdraw.sos_withdraw (beneficiar, amount) ;
    }

*/

    address External_Storage_addr;
     address Userstory_smart_contr_addr;
     address  Project_smart_contr_addr;
     address  ANGtokenaddr;


    function team_withdraw(bytes32 UserStoryAddr) payable public
    {

        userstory userstorycurrent =  userstory(Userstory_smart_contr_addr);

        ( uint256  project_ID, //+
          uint256   User_story_number,
          bytes32   DFS_Hash,
          bytes4   DFS_type,
          uint256  Story_Amount_ANG,
          uint256   Story_Amount_Tokens,
          uint256  start_date,
          uint256  duration,
          uint256   sum_raised, //+
          uint256  sum_accepted,
          uint256  Ask_end_from_project,
          uint256  finished  ) = userstorycurrent.UserStories(UserStoryAddr);

        project Projectcontractcurrent =  project(Project_smart_contr_addr);
        address   ProjecttokenAddr = Projectcontractcurrent.ProjectList(project_ID);
        (uint256   project_ID_pr,
        address  project_owner_address, //+
        address   _DARF_system_address,
        bytes32  DFS_Project_describe,
        bytes4   DFS_type_pr) = Projectcontractcurrent.Projects(ProjecttokenAddr);
        require((project_owner_address == msg.sender)) ;  // only team lead can withdraw
            token(ANGtokenaddr).transfer(address(this), msg.sender, sum_raised);
    }

   function sos_withdraw (address beneficiar, uint256 amount) payable public  onlyOwner
   {
       ExternalStorage ES = ExternalStorage(External_Storage_addr);
       token(ANGtokenaddr).transfer(address(this), beneficiar, amount);
   }


       function _initExternalStorage(address Externalstorageaddr) public onlyAdmins (msg.sender) {

        External_Storage_addr = Externalstorageaddr;
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        ES.setAddressValue("tokensale/implementation/base_withdraw", address(this));
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
