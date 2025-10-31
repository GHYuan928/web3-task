// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract RevertString {
    function revertString(string memory str) external pure returns (string memory){
       //转换成 bytes
       bytes memory bytesStr = bytes(str);
       uint len = bytesStr.length;
       // 定义一个空的 bytes
       bytes memory reverBytes = new bytes(len);

       for (uint i=0; i<len; i++) {
         reverBytes[i] = bytesStr[len - i -1];
       }
       return string(reverBytes);
    }
}