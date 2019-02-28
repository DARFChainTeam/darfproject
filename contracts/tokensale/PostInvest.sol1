//todo: move non-finance data to Rinkeby/Kovan?

pragma solidity ^0.4.24;


import "../tokens/token.sol";


contract PostInvest {

    address public owner;
    address public beneficiar;
    address public token_address;


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

    struct Story_Bakers {
        address baker;
        uint baked_sum;
        bool accept_work;

    }

    struct UserStory {
                          uint projectID;
                          //user_address: address,
                          bytes32 IPFSHash;
                          bool project_accept;  // TODO tx transaction of acceptance
                          mapping (uint => Story_Bakers) bakers;  //# several users who baked story
                          bool  project_signin; // TODO several team members?
                          uint256 start_date; // timestamp,
                          uint duration; // timedelta,
                          bool confirm_end_from_project; // TODO several team members?
                         // mapping (uint => Story_Bakers) confirm_end_from_user; // several users
                          uint StoryAmountDarf;
                          uint StoryAmountTokens;

                        }

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

     mapping (address => Admin) public _admins;
//==============================================================================
//Modification and access right------------------------------------------------

    modifier OnlyAdmin(address _sender_address) {
          require(_admins[_sender_address].active == true);
          _;

        }

    modifier OnlyOwner(address _sender_address) {
      require(projects.project_owner_address == _sender_address);
      _;

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

// todo return_fund () //- make checking that another side transfer fund to escrow too. If fund transfered, \
// escrow will locking, and devepol starts, if not - fund can be returned to owner.


function exchange_DARF2ETH (uint sum_DARF) payable public {
//uint Sum_ETH = sum_DARF/darf_tokens_rate*(1 ether);
uint Sum_ETH = sum_DARF/darf_tokens_rate;
//  if (DARFtoken(token_address).balanceOf(msg.sender) > sum_DARF && address(this).balance > Sum_ETH ) {

DARFtoken(token_address).transferFrom(msg.sender, address(this), sum_DARF);
msg.sender.transfer(Sum_ETH);

//        }
}
}