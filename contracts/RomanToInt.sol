// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract RomanToInt {
    mapping (bytes1 => uint) romanMapping;
    constructor() {
        romanMapping["I"] = 1;
        romanMapping["V"] = 5;
        romanMapping["X"] = 10;
        romanMapping["L"] = 50;
        romanMapping["C"] = 100;
        romanMapping["D"] = 500;
        romanMapping["M"] = 1000;
    }
    function romanToInt(string memory roman) external view returns (uint){
        // str to bytes
        bytes memory strBytes = bytes(roman);
        uint len = strBytes.length;
        require(len>=1 && len<=15, 'invalid input 1~15');
        int total=0;
        for(uint i=0; i< len;i++){
            bytes1 currentChar = strBytes[i];
            uint currentValue = romanMapping[currentChar];
            require(currentValue >0 ,"invalid input");
            if(i+1 <len  && romanMapping[strBytes[i+1]] > currentValue){
                total -= int(currentValue);
            }else {
                total += int(currentValue);
            }
        }
        return uint(total);
    }
}