pragma solidity ^0.5.0;

contract  project_interface  {

    function  setrights(address Projecttokenaddr,  uint256 grade, uint256 floorsum) public  ;

    function checkrights (address Project_token_addr) public returns (uint256) ;

    function create_project (address Projecttokenaddr, bytes32 DFSProjectdescribe, bytes4 DFStype)  public ;

    function change_project_info (address Projecttokenaddr, address owner, bytes32 DFSProjectdescribe, bytes4 DFStype)   public;

     function give_project_data(uint256 ProjectID) public returns(address, uint256,address,address, bytes32,bytes4) ;

    function finish_project (address Projecttokenaddr) public returns (uint256 ) ;

    function project_add_state(address Projecttokenaddr,  bytes32 DFSchangesaddr, bytes32 DFSchangeshash,bytes32 POA_addr) public returns (uint256) ;

     function project_get_state(address Projecttokenaddr, uint timestamp ) public returns(bytes32) ;
}