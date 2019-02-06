pragma solidity ^0.4.0;

contract userstory {

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

    function start_user_story(projectID:int128,IPFSHash:bytes32,storyAmountDarf:uint256){

    }

    function add_user_story_comment () public {
}


    function finish_userstory(){

    }
}
