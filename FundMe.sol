//raise funds from users
//withdraw funds
//set minimum contribution amt

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    address [] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    uint256 public minimumUsd = 5e18; //give 18 decimal places to 5 dollars
    //keyword payable allows function accept native token
    function fund() public payable{

        require (msg.value.getConversionRate() >= 5, "Didn't send enought ETH"); //1 ETH  = 1e18 or 10**18 Weis
        //msg.value.getConversionRate();  // msg.value is automatcially being passed into getConversionRate(), but need to put the value of second variable into the parenthesis
        funders.push(msg.sender);
        //addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        addressToAmountFunded[msg.sender] += msg.value;
    }

    // withdraw function
    function withdraw() public{
        // for(/* starting index, ending index, step amount*/)
        for(uint256 funderIndex=0; funderIndex < funders.length; funderIndex++ /*funderIndex++: funderIndex = funderIndex +1 */) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] =0; // reset funder amount to 0 since amt is being withdrawn 
        }

        //reset funders array
        funders = new address[](0) // (0) reset array to size of 0

    }


}
