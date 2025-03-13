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

        require (getConversionRate(msg.value) >= 5, "Didn't send enought ETH"); //1 ETH  = 1e18 or 10**18 Weis
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }


}
