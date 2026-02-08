// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Mammal {

    uint public age;
    bool public isWarmBlooded = true;

    modifier needAdultonly(uint _age) {
       require( _age >= 2, "Too young");
    _;
    }

    function Breathe() public pure returns (string memory) {
        return "Breathing...";
    }

}

contract Dog is Mammal{
    
    function bark () public pure returns (string memory) {
        return "Woof";
    }
    function setAge (uint _age) public needAdultonly (_age) {
        age = _age;
    }
}

contract Monkey is Mammal{
    
    function climb () public pure returns (string memory) {
        return "Climbing Trees";
    }
    function setAge (uint _age) public needAdultonly (_age) {
        age = _age + 1;
    }
}

