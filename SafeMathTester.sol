// SPDX-License-Idenitifer: MIT

pragma solidity ^0.6.0;

//In version 0.8.0 overflow and underflow is addressed

contract SafeMathTester{
    uint8 public bigNumber = 255;

    function add() public {


        bigNumber = bigNumber + 1;

        //unchecked {bigNumber = bigNumber + 1}
    }

}

