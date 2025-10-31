// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
contract BinarySearch {
    
    function bSearch(int[] calldata arr, int target) external pure returns (int) {
        uint left = 0;
        uint right = arr.length -1;
        while (left <= right) {
            uint mid = (left + right)/2;
            if(arr[mid] == target){
                return int(mid);
            }else if(arr[mid] > target){
                right = mid -1;
            }else {
                left  = mid+1;
            }

        }
        return -1;
    }
}