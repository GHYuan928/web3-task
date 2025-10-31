// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract IntToRoman {
    mapping ( uint => string) romanMapping;
    constructor() {
        romanMapping[1] = "I";
        romanMapping[5] = "V";
        romanMapping[10] = "X";
        romanMapping[50] = "L";
        romanMapping[100] = "C";
        romanMapping[500] = "D";
        romanMapping[1000] = "M";
    }

    function intToRoman(uint num) external view returns (string memory){
        require(num>=1 && num <=3999, 'plz input 1-3999');
        int zs = 1;
        if (num >= 1000) {
            zs = 1000;
        } else if (num >= 100) {
            zs = 100;
        } else if (num >= 10) {
            zs = 10;
        }
        string memory resStr;
        while (zs > 0){
            uint i = num / uint(zs);
            if(i==4 || i==9){
                string memory first = romanMapping[uint(zs)];
                string memory second = romanMapping[(i+1) * uint(zs)];
                resStr = string.concat(resStr,first, second);
                num -= (i * uint(zs));
                zs /= 10;
            }else if(i>=5){
                string memory first = romanMapping[5 * uint(zs)];
                resStr = string.concat(resStr,first);
                num -= (5 * uint(zs));
                if(i-5==0){
                    zs /= 10;
                }
            }else {
                string memory first = romanMapping[1 * uint(zs)];
                resStr = string.concat(resStr,first);
                num -= (1 * uint(zs));
                if(i-1==0){
                    zs /= 10;
                }
            }
        }
        return resStr;
    }
}