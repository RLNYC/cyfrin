//raise funds from users
//withdraw funds
//set minimum contribution amt

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();  /// this is a custom error

contract FundMe {
    using PriceConverter for uint256;

    address [] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    uint256 public constant MINIMUM_USD = 5e18; //give 18 decimal places to 5 dollars

    //keyword payable allows function accept native token
    function fund() public payable{

        require (msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enought ETH"); //1 ETH  = 1e18 or 10**18 Weis
        //msg.value.getConversionRate();  // msg.value is automatcially being passed into getConversionRate(), but need to put the value of second variable into the parenthesis
       
        funders.push(msg.sender);

        //addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        // for(/* starting index, ending index, step amount*/)
        for(uint256 funderIndex=0; funderIndex < funders.length; funderIndex++ /*funderIndex++: funderIndex = funderIndex +1 */) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] =0; // reset funder amount to 0 since amt is being withdrawn 
        }

        //reset funders array
        funders = new address[](0); // (0) reset array to size of 0

        //send withdrawal fund
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Withdrawal Call Failed");

    }


    // set owner modifier
    modifier onlyOwner {
        //require(msg.sender == i_owner, "You are not the owner");
        //custom error
        if(msg.sender != i_owner) { revert NotOwner();}
        _;
    }

    // what happens if someone send this contract ETH without calling Fund function

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }



}
