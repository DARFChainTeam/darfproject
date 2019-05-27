pragma solidity ^0.5.0;

contract userstory_inteface {
 function give_userstory_data1(bytes32 UserStoryAddr) external returns ( uint256 ,
                                                                      uint256 ,
                                                                      bytes32 ,
                                                                      bytes4 ,
                                                                      uint256 ,
                                                                      uint256);
function give_userstory_data2(bytes32 UserStoryAddr) external returns (
                                                                      uint256 ,
                                                                      uint256 ,
                                                                      uint256 ,
                                                                      uint256 ,
                                                                      uint256 ,
                                                                      uint256 );
    function start_user_story (uint256 ProjectID, uint256 Userstorynumber, bytes32 DFSHash, bytes4 DFStype,  uint256 StoryAmountANG, uint256 StoryAmounttoken, uint256 Startdate, uint duration)   public  returns (bytes32);

    function invest(bytes32 UserStoryAddr, uint256 bakedsumANG) public payable;
    function finish_userstory_from_team(bytes32 UserStoryAddr, uint256 ProjectID) public returns (uint);
     function accept_work_from_bakers (bytes32 UserStoryAddr, bool acceptance) public;
    function abort_by_team (bytes32 UserStoryAddr, bool abortfromteam, string memory why ) public;

    function abort_by_bakers (bytes32 UserStoryAddr, bool abortfrombakers, string memory why) public;
}
