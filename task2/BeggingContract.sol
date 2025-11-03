// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/access/Ownable.sol";

contract BeggingContract is Ownable{
    // 捐赠者的捐赠金额
    mapping (address => uint) private donorsMapping;
    // 所有捐赠者，用于排行榜
    address[] private donors;

    // 提款事件
    event DonateReceived(address indexed  donor, uint value);
    // 提款事件
    event FundsWithdrawn(address indexed  donor, uint value);

    constructor() Ownable(msg.sender){}

    // 用户向合约发送以太币，并记录捐赠信息
    function donate() external payable {
        require(msg.value > 0, 'donate must >0');
        if(donorsMapping[msg.sender] == 0){
            donors.push(msg.sender);
        }
        donorsMapping[msg.sender] += msg.value;
        emit DonateReceived(msg.sender, msg.value);
    }

    // 合约接收ETH时触发的函数
    receive() external payable { 
        require(msg.value > 0, 'msg value must >0');
        if(donorsMapping[msg.sender] == 0){
            donors.push(msg.sender);
        }
        donorsMapping[msg.sender] += msg.value;
        emit DonateReceived(msg.sender, msg.value);
    }
    
    // 所有者提取所有资金
    function withdraw() external payable onlyOwner {
        uint balance = address(this).balance;
        require(balance >0 , 'no balance to withdraw');
        payable(owner()).transfer(balance);
    }

    // 查询某个地址的捐赠金额
    function getDonation(address donorAddr) external view returns (uint){
        require(donorAddr != address(0), 'address invilid');
        return donorsMapping[donorAddr];
    }
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    // 捐赠金额最多的前 3 个地址
    function queryTop3Donor() external view returns (address[3] memory) {
        require(donors.length >0, 'current no donors');
        address[] memory tempDonors = new address[](donors.length);
        uint[] memory tempValues = new uint[](donors.length);
        for (uint i=0; i<donors.length; i++) 
        {
            tempDonors[i] = donors[i];
            tempValues[i] = donorsMapping[donors[i]];
        }
        for (uint i = 0; i < tempDonors.length - 1; i++) {
            for (uint j = 0; j < tempDonors.length - i - 1; j++) {
                if (tempValues[j] < tempValues[j + 1]) {
                    // 交换金额
                    (tempValues[j], tempValues[j + 1]) = (tempValues[j + 1], tempValues[j]);
                    // 交换地址
                    (tempDonors[j], tempDonors[j + 1]) = (tempDonors[j + 1], tempDonors[j]);
                }
            }
        }
        address[3] memory top3;
        uint256 count = tempDonors.length < 3 ? tempDonors.length : 3;
        for (uint i=0; i<count ; i++) 
        {
            top3[i] = tempDonors[i];
        }
        return top3;
    }

}