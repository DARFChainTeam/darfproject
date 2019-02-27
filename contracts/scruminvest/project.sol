pragma solidity ^0.4.24;
import "../tokens/token.sol";
import "../admin/ExternalStorage.sol";
import "../admin/administratable.sol";

contract project {

    address External_Storage_addr;
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
        bytes32 DFS_changes_addr; // addresses of paroled archive of DB increment in DFS (IPFS/SWarm)
        bytes32 DFS_changes_hash; // hash of DB state
        bytes4 DFS_type;
        bytes32 POA_addr; // addresses of current Proof-of-Accounting state in DFS (IPFS/SWarm)
        uint timestamp;

    }

    mapping (address => project_state) Project_statuses;// addresses of project's states  in IPFS/swarm

    struct Project{
        uint256 project_ID; //assign by increment and not change?
        address project_owner_address;
        address _DARF_system_address; // ETH address of node that updates project state
        bytes32 DFS_Project_describe;// addresses of intial project's describe in DFS (IPFS/SWarm)
        bytes4 DFS_type;
        mapping (uint => RightsList) rights;
        // mapping (uint => UserStory) stories;


    }

    mapping (address => Project) public Projects ; // AKA projectID
    address[] public ProjectList; // array to access projects

    modifier  OnlyOwner(address _project_address) {
        require(Projects[Project_token_addr].project_owner_address == msg.sender);
        _;
    }


//    struct Admin {
//        bool active;
//        }
//    mapping (address => Admin) public _admins;


  //function setAdmin(address _admin_address, bool _admin_state) OnlyOwner(msg.sender) {
  //    _admins[_admin_address].active = _admin_state;
  //  }


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
                project_token =  Token (Projects[Project_token_addr].project_token_addr);
                if (project_token.balanceOf(msg.sender) > Projects[Project_token_addr].rights(grade).floor_sum ){
                    return grade;
                }

        }
        return 0 ; // no money no honey
    }

    event New_project (address owner_address , address token, bytes32 DFSProjectdescribe, address _DARFsystemaddress);

    function create_project (address token, bytes32 DFSProjectdescribe, uint DFStype) OnlyOwner public {

        require(token_deposit (token, ANG_system_addr, our_share));

            Projects[token].project_owner_address = msg.sender;
            Projects[token].DFS_Project_describe = DFSProjectdescribe;
            Projects[token].DFS_type = DFStype;
            ProjectList.push(token);
            Projects[token].Project_ID = ProjectList.lenght();
            emit New_project (Projects[token].project_owner_address, token, Projects[token]
                .Project_describe, Projects[token].Project_ID  ) ;

}

    function change_project_info (address token, address owner, bytes32 DFSProjectdescribe, uint                                        DFStype) OnlyOwner  public {

            Projects[token].project_owner_address = owner;
            Projects[token].DFS_Project_describe = DFSProjectdescribe;
            Projects[token].DFS_type = DFStype;

        //todo: or via Registry?
        // owner
        // DARF node
        // addrr_describe



}
    event finished_project (address token);

    function finish_project (address token) public {
        emit finished_project (token);

}
        function project_add_state(address token,  bytes32 DFSchangesaddr, bytes32 DFSchangeshash,                  bytes32 POA_addr) public returns (uint) {
       if(msg.sender!=Projects[token]._DARF_system_address)
      { throw; }
       else {
            uint timestamp = now;
            address ProjectAddr = keccak256(token, timestamp);
            Project_statuses[ProjectAddr].timestamp = timestamp;
            Project_statuses[ProjectAddr].projectID =Projects[token].Project_ID ;
            Project_statuses[ProjectAddr].DFS_changes_addr = DFSchangesaddr;
            Project_statuses[ProjectAddr].DFS_changes_hash = DFSchangeshash;
            Project_statuses[ProjectAddr].POA_addr = POA_addr;
            return timestamp;
       }

    }

     function project_get_state(address token, uint timestamp ) public returns(address) {

        if (checkrights(token) > 0) { //returns state
            return Project_statuses[keccak256(token, timestamp)].DBchangesaddr ;
        }
        else { //returns only PoA
            return Project_statuses[keccak256(token, timestamp)].POA_addr ;

            }

    }
    //todo todo - 5% tokens deposit to platform



    function token_deposit (address _tokenAddress, address ANG_system, uint platform_share) returns(bool) {


        // todo check minted amount of tokens
        Token_total_supply = Token(_tokenAddress).totalSupply;
        //  todo check that platform_share is transferred to address
        token_balance = _TokenInterface(_tokenAddress).balanceOf(ANG_system);
        return (Token_total_supply * platform_share <= token_balance);
    }

   function _setExternalstorageaddr(address Externalstorageaddr ) public onlyAdmins {
        External_Storage_addr = Externalstorageaddr;


    }

   function _init() public onlyAdmins {

        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        Projectaddr = ES.setAddressValue("scruminvest/project", address(this));

    }


    // todo billing for updates of project state: transfer ANG to our address equal as gas +5% calculate transaction  fee when saving project state


}

contract _TokenInterface {
    function balanceOf(address whom) view public returns (uint);
}
