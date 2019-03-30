pragma solidity ^0.5.0;
import "../tokens/token.sol";
import "../admin/interface/ExternalStorage.sol";


contract project is ExternalStorage {


    address External_Storage_addr;

/*
    constructor(address _token_address) public {
    address owner = msg.sender;
    address  beneficiar = msg.sender;
    address  token_address = _token_address;
  }
*/
/*

    struct RightsList {
        // byte grade;
       // uint256 ProjectID;
        uint256[8] floor_sum;

    }
*/
    //uint256[8]  public rights;

    mapping (address => uint256[8]) Project_rights;  // 0-7 grades - access rights to project's information grades
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
    // 0-7 grades use by default to reduce gas issues
    // TODO: this grades'd be mapped with access right in ERP

    struct project_state {
        uint256 project_ID;
        bytes32 DFS_changes_addr; // addresses of paroled archive of DB increment in DFS (IPFS/SWarm)
        bytes32 DFS_changes_hash; // hash of DB state
        bytes4 DFS_type;
        bytes32 POA_addr; // addresses of current Proof-of-Accounting state in DFS (IPFS/SWarm)
        uint timestamp;

    }

    mapping (bytes32 => project_state) Project_statuses;// addresses of project's states  in IPFS/swarm

    struct Project{
        uint256 project_ID; //assign by increment and not change?
        address project_owner_address;
        address _DARF_system_address; // ETH address of node that updates project state
        bytes32 DFS_Project_describe;// addresses of intial project's describe in DFS (IPFS/SWarm)
        bytes4 DFS_type;
             // rights  0-7 rights grades use by default to reduce gas issues - moved to Project_rights

        // mapping (uint => UserStory) stories;


    }

    mapping (address => Project) public Projects ; //
    address[] public ProjectList; // array to access projects AKA projectID

    modifier  OnlyProjectOwner(address _project_address) {
        require(Projects[_project_address].project_owner_address == msg.sender);
        _;
    }


//    struct Admin {
//        bool active;
//        }
//    mapping (address => Admin) public _admins;


  //function setAdmin(address _admin_address, bool _admin_state) onlyOwner(msg.sender) {
  //    _admins[_admin_address].active = _admin_state;
  //  }




    function  setrights(address Projecttokenaddr,  uint256 grade, uint256 floorsum) public  OnlyProjectOwner(Projecttokenaddr)   {
        require (grade < 8);
            Project_rights[Projecttokenaddr][grade] = floorsum;

    }

    function checkrights (address Project_token_addr) public returns (uint256) {
        for (uint256 grade = 7; grade >= 0; grade--) {
                token projecttoken =  token (Project_token_addr); //Projects[Project_token_addr].project_token_addr);
                if (projecttoken.balanceOf(msg.sender) > Project_rights[Project_token_addr][grade] ){
                    return grade;
                }

        }
        return uint256(0) ; // no money no honey
    }

    event New_project (address owner_address , address Projecttokenaddr, bytes32 DFSProjectdescribe, address _DARFsystemaddress);

    function create_project (address Projecttokenaddr, bytes32 DFSProjectdescribe, bytes4 DFStype) OnlyProjectOwner(Projecttokenaddr) public {
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        address  ANG_system_addr = ES.getAddressValue("ANG_system_addr");
        uint256 our_share100 = ES.getUIntValue("our_share100");
        require(check_token_deposit(Projecttokenaddr, ANG_system_addr, our_share100));

            Projects[Projecttokenaddr].project_owner_address = msg.sender;
            Projects[Projecttokenaddr].DFS_Project_describe = DFSProjectdescribe;
            Projects[Projecttokenaddr].DFS_type = DFStype;
            ProjectList.push(Projecttokenaddr);
            Projects[Projecttokenaddr].project_ID = ProjectList.length;
        emit New_project (Projects[Projecttokenaddr].project_owner_address, Projecttokenaddr, Projects[Projecttokenaddr].DFS_Project_describe,  Projects[Projecttokenaddr]._DARF_system_address ) ;

}

    function change_project_info (address Projecttokenaddr, address owner, bytes32 DFSProjectdescribe, bytes4 DFStype)  public OnlyProjectOwner(Projecttokenaddr) {

            Projects[Projecttokenaddr].project_owner_address = owner;
            Projects[Projecttokenaddr].DFS_Project_describe = DFSProjectdescribe;
            Projects[Projecttokenaddr].DFS_type = DFStype;

        //todo: or via Registry?
        // owner
        // DARF node
        // addrr_describe



}
    event finished_project (address Projecttokenaddr);

    function finish_project (address Projecttokenaddr) public {
        emit finished_project (Projecttokenaddr);

}
        function project_add_state(address Projecttokenaddr,  bytes32 DFSchangesaddr, bytes32 DFSchangeshash,bytes32 POA_addr) public returns (uint256) {
       require(msg.sender == Projects[Projecttokenaddr]._DARF_system_address);
            uint256 timestamp = now;
            bytes32 ProjectAddr = keccak256(abi.encodePacked (Projecttokenaddr, timestamp));
            Project_statuses[ProjectAddr].timestamp = timestamp;
            Project_statuses[ProjectAddr].project_ID =Projects[Projecttokenaddr].project_ID ;
            Project_statuses[ProjectAddr].DFS_changes_addr = DFSchangesaddr;
            Project_statuses[ProjectAddr].DFS_changes_hash = DFSchangeshash;
            Project_statuses[ProjectAddr].POA_addr = POA_addr;
            return timestamp;


    }

     function project_get_state(address Projecttokenaddr, uint timestamp ) public returns(bytes32) {

        if (checkrights(Projecttokenaddr) > 0) { //returns state
            return Project_statuses[keccak256(abi.encodePacked(Projecttokenaddr, timestamp))].DFS_changes_addr;
        }
        else { //returns only PoA
            return Project_statuses[keccak256(abi.encodePacked(Projecttokenaddr, timestamp))].POA_addr;

            }

    }
    //todo todo - 5% tokens deposit to platform



    function check_token_deposit(address _tokenAddress, address ANG_system, uint256 platform_share100) internal returns(bool) {


        // todo check minted amount of tokens
        uint256 Token_total_supply = token(_tokenAddress).totalSupply();
        //  todo check that platform_share is transferred to address
        uint256 token_balance = _TokenInterface(_tokenAddress).balanceOf(ANG_system);
        return ((Token_total_supply * platform_share100 /100) <= token_balance);
    }



   function _initExternalStorage(address Externalstorageaddr) public onlyAdmins (msg.sender) {

        External_Storage_addr = Externalstorageaddr;
        ExternalStorage ES = ExternalStorage(External_Storage_addr);
        ES.setAddressValue("scruminvest/project", address(this));

    }


    // todo billing for updates of project state: transfer ANG to our address equal as gas +5% calculate transaction  fee when saving project state

    function toBytes (uint256 x) internal view returns (bytes memory b) {
        b = new bytes(32);
        assembly { mstore(add(b, 32), x) }
    }

}

contract _TokenInterface {
    function balanceOf(address whom) view public returns (uint);
}
