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

    function accept_user_story_from_project(UserStoryID:int128) public { // team accepts userstory for work from backlog


}

    function sign_in_user_story_from_investors (UserStoryID:int128) public { //sign_in_user_story_from_user(UserStoryID:int128)
// investors signup userstory when negotiations finished
// investors  send DARF to userstory if agree


}
    function sign_in_user_story_from_project(UserStoryID:int128)public { # team signup userstory when negotiations finished
}


    function  confirm_end_from_project(UserStoryID:int128) public { # team finished the userstory and initiate acceptance from investors

}


    function def confirm_end_from_investors(UserStoryID:int128) public # investors accept work
    {


    }

//if team fails... deadline is broken, undersing LT then 50% of sum and one on investors initiate refunding
//public
    function  userstory_fail_refund (UserStoryID: int128):
    {


    }


    function change_conditions (darf2Eth:uint256, TokenShare:decimal, DARFShare:int128) public {


}


    function userstory(){

    }
}
