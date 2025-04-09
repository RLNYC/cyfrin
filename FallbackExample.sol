// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract FallbackExample {
    uint256 public result;

    // when value field is not 0 and CALLDATA field is empty, this function would be triggered
    receive() external payable { 
        result =1;
    }

    // when value field is not 0 and CALLDATA field is not empty(has data input), this function would be triggered
    fallback() external payable {
        result = 2;
    }
}