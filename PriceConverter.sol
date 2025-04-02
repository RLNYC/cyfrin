// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


// library cannot have state variables and all functions must be internal
library PriceConverter{
    function getPrice() internal view returns (uint) {
        //address sepolia 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 price, , , ) = priceFeed.latestRoundData(); // only want to retrieve price
        //8 decimals in chainlink price, but msg.value has 18
        // price is int256, but msg.value is uint256=>need to use typecasting
        return uint256(price * 1e10); //type casting
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        uint256 ethPrice = getPrice();
        //both ethAmount and ethPrice has 18 decimals, multiplying them would generate 32 decimals
        uint256 ethAmountInUsd = (ethAmount * ethPrice) / 1e18;
        return ethAmountInUsd;
    }

}