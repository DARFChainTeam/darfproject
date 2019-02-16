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

    struct project_state {
        uint projectID;
        bytes32 DB_changes_addr;
        bytes32 POA_addr;
        uint timestamp;

    }

    mapping (uint256 => project_state) Project_statuses;// addresses of project's states  in IPFS
    bytes32[] Project_list; // array to access projects


    struct Project{
        uint256 project_ID; //assign by increment and not change?
        address project_owner_address;
  //      address project_token_addr;  // (ERC20),
        bytes32  IPFS_Describe;// addresses of project's states  in IPFS
        mapping (uint => RightsList) rights;
        // mapping (uint => UserStory) stories;


    }

    mapping (address => Project ) public projects ; // AKA projectID
    bytes32[] public Project_list;


    struct Admin {
        bool active;
        }
    mapping (address => Admin) public _admins;


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

    function  setrights(address Project_token_addr,  mapping (uint => RightsList) rights) public  OnlyOwner(msg.sender)   {
        Projects[Project_token_addr].rights = rights;

    }

    function checkrights (address Project_token_addr) public {
        for (uint grade = Projects[Project_token_addr].rights.length(); grade > 0; grade--) {
                project_token =  ERC20 (Projects[Project_token_addr].project_token_addr);
                if (project_token.balanceOf(msg.sender) > Projects[Project_token_addr].rights(grade).floor_sum ){
                    return grade;
                }

        }
        return 0 ; // no money no honey
    }

    event New_project (address owner_address , address token, bytes32 IPFSDescribe, ProjectID );

    function create_project (address token, bytes32 IPFSDescribe) public {
        Projects[token].project_owner_address = msg.sender;
        Projects[token].IPFS_Describe = IPFSDescribe;
        Project_list.push(token);
        Projects[token].Project_ID = Project_list.lenght();
        emit New_project (Projects[token].project_owner_address, token, Projects[token].IPFS_Describe, Projects[token].Project_ID  ) ;

}

    function change_project_info () public {
//todo or via Registry?


}
    event finish_project (address token);

    function finish_project (address token) public {
        emit finish_project (token);

}
    function project_add_state() public {

    }

     function project_get_state() public {

    }
}
