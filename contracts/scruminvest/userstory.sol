pragma solidity ^0.4.0;

contract userstory {

    struct Story_Bakers {
        address baker;
        uint baked_sum;
        bool accept_work;

    }

    struct UserStory {
                          uint projectID;
                          address project_token;
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
    byte32[]

    event Newuserstory (uint ProjectID, address Projtoken, bytes32 IPFSHash, uint StoryAmountANG, uint StoryAmounttoken, uint Deadline);

    function start_user_story (uint ProjectID,  address Projtoken, bytes32 IPFSHash, uint StoryAmountANG, uint StoryAmounttoken, uint Deadline) public OnlyOwner(msg.sender) returns (uint){



    emit  Newuserstory (ProjectID, Projtoken, IPFSHash,  StoryAmountANG,  StoryAmounttoken, Deadline);
    }

   // function add_user_story_comment () public { }



    function finish_userstory(){

    }
}
