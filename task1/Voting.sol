// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Voting {
    mapping (string username => uint count) public  voting;
    string[] public candidates;
    // 投票
    function vote(string memory name) external  {
        candidates.push(name);
        voting[name] += 1;
    }
    // 获取票数
    function getVotes(string memory name) external view returns (uint){
        return voting[name];
    }
    // 重置
    function resetVotes()external {
        uint i=0;
        uint len = candidates.length;
        delete candidates;
        for(;i<len;i++){
            delete voting[candidates[i]];
        }
    }
}