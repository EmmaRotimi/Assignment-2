// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

//Writing a code to produce time of curfew for a type of school.
abstract contract School {
    function Curfew () public virtual returns (string memory);
}

contract FUTA is School {
    function Curfew () public pure override returns (string memory){
        return "9pm";
    }
}