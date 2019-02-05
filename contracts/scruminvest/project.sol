pragma solidity ^0.4.0;

contract project {


    constructor(address _token_address) public {
    owner = msg.sender;
    beneficiar = msg.sender;
    token_address = _token_address;
  }


    struct RightsList {
        // byte grade;
       // uint projectID;
        uint floor_sum;

    }

    //mapping (uint => RightsList ) project_rights

    struct IPFS_addresses {
        uint projectID;
        bytes32 IPFS_addr;
    }

    mapping (uint256 => IPFS_addresses )  project_statuses;// addresses of project's states  in IPFS

    struct Project{
       // uint256 projectID; //assign by increment and not change?
        address project_owner_address;
        address project_token_addr;  // (ERC20),
        bytes32  IPFSDescribe;// addresses of project's states  in IPFS
        mapping (uint => RightsList) rights;
        // mapping (uint => UserStory) stories;


    }

    mapping (uint => Project ) projects ; // AKA projectID

     struct Admin {
        bool active;
        }


  function setAdmin(address _admin_address, bool _admin_state) OnlyOwner(msg.sender) {
      _admins[_admin_address].active = _admin_state;
    }


    // set and check grade of rights for project
    // level of access based on amount  of project's token on user's address.
    // f.e. 10 tokens - means "1"st level -  trafficlight spectator,
    // 100 tokens - "2"nd level  - reports analyser,
    // 1000 tokens - "3"td level - transaction auditor
    // 10000 tokens - "4"th level - scrum participator
    // 100000 tokens - "5"th - team member
    // 1000000 tokens - "6"s level- manager
    // 10000000 tokens - "7"s lev - top manager
    // or another grade list
    // 10 grades use by default to reduce gas issues
    // TODO: this grades'd be mapped with access right in ERP

    function  setrights(uint ProjectID,  mapping (uint => RightsList) rights) public  OnlyOwner(msg.sender)   {
        Projects[ProjectID].rights = rights;

    }

    function checkrights (uint ProjectID ) public {
        for (uint grade = Projects[ProjectID].rights.length(); grade > 0; grade--) {
                project_token =  ERC20 (Projects[ProjectID].project_token_addr);
                if (project_token.balanceOf(msg.sender) > Projects[ProjectID].rights(grade).floor_sum ){
                    return grade;
                }

        }
        return 0 ; // no money no honey
    }

    function create_project (owner_address: address,token:address,IPFSDescribe:bytes32){



}

    function change_project_info (){



}
    function project(){

    }
}
