// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Voting_System{

    address public owner; // storing the address of the contract initiator or deployer and making it possible for all to see.
    bool public Election_underway; // So that users can know if the conract is active

    constructor(){
        owner = msg.sender;
    }
 mapping (address => bool) public admins;

    modifier Admin_only(){
        require (msg.sender == owner || /*or*/ admins[msg.sender], "Not Authorized"); // contract modifier function only possible by assigned admin, else Not Authorized
        _;
    }   
    // Now to give admin access to other addresses:
    function addAdmin (address _admin)public{
        require(msg.sender == owner, "Only owner"); //only contract OWNER can add admin.
        admins[_admin]=true;
    }
    //Now to group Electroral Candidates and Voters i'll add a struct for each.

    struct Candidate {
        string name;
        uint numberOfVotes;
    }

    struct Voter {
        bool registered; //storing voters' registeration status
        bool hasVoted; //to avoid multiple votes
    }
    // creating an array to store add candidates and map voters to thier status 
    Candidate[] public candidates;
    mapping (address => Voter) public voters;

    //Now the Owner and Admin only accessible functions:
    function addCandidate(string memory _name) public Admin_only{
        candidates.push(Candidate(_name, 0)); //each added candidate gets added to the end of an array, index starting from 0
    }
    function registerVoter(address _voter) public Admin_only {
        voters[_voter] = Voter(true,false); //Is the address a registered voter or naa 
    }

    //Now to Begin the election:

    function startElection() public Admin_only{
        Election_underway = true;
    }
    function endElection() public Admin_only{
        Election_underway = false;
    }

    //Now to implement avoiding double Voting or cheating

    function vote (uint _candidateindex) public{
        require (Election_underway, "Elecion not active");
        require (voters[msg.sender].registered, "user not registered");
        require (!voters[msg.sender].hasVoted, "Already Voted"); // exclamation mark would mean anyone NOT voter that has registered

        voters[msg.sender].hasVoted = true; //Find status of any voter using thier address
        candidates[_candidateindex].numberOfVotes++; //For every candidate vote, thier votecount increases by 1

    } 
}