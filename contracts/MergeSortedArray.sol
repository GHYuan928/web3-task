// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
contract MergeSortedArray {
    
    function sort(int[] calldata arr1, int[] calldata arr2) external pure returns (int[] memory){
        uint len1 = arr1.length;
        uint len2 = arr2.length;
        uint i=0;
        uint j=0;
        uint z=0;
        int[] memory resArr = new int[]((len1+len2));

        while (i<len1 && j<len2 ) 
        {
            int val1=arr1[i];
            int val2=arr2[j];
            if(val1 <= val2){
                resArr[z] = val1;
                i++;
            } else {
                resArr[z] = val2;
                j++;
            }
            z++;
        }
      
        while (i < len1) 
        {
            int val1=arr1[i];
            resArr[z] = val1;
            i++;
            z++;
        }
        while (j < len2) 
        {
            int val1=arr2[j];
            resArr[z] = val1;
            j++;
            z++;
        }
        
        return resArr;
    }
}