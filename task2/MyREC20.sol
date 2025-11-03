// SPDX-License-Identifier: MIT
pragma solidity ^0.8;


interface MyIREC20 {
    // 代币转账时 事件
    event Transfer(address indexed from, address indexed to, uint value);
    // 授权额度 事件
    event Approval(address indexed  owner, address indexed spender, uint value);

    // 总供应量
    function totalSupply() external view returns (uint256);
    // 账户余额
    function balanceOf(address account) external view returns (uint256);
    // 授权额度查询
    function allowance(address owner, address spender) external view returns (uint256);

    // 转账
    function transfer(address to, uint256 value) external returns (bool);
    // 授权
    function approve(address spender, uint256 value) external returns (bool);
    // 代理转账
    function transferFrom(address from, address to, uint256 value) external returns (bool);

}

contract MyERC20 is MyIREC20{
    // 名称，符号，小数位，总量
    string public name;
    string public symbol;
    uint8 public  decimals = 18;
    uint256 private _totalSupply;

    // 账户额度
    mapping (address => uint) private _balances;
    // 授权额度
    mapping (address => mapping (address => uint)) private _allowances;

    address private _owner;

    modifier onlyOwner(){
        require(_owner == msg.sender,'only owner call func...');
        _;
    }

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        _owner = msg.sender;
    }
    function mint(address owmer, uint256 value) external onlyOwner {
        _balances[owmer] += value;
        _totalSupply += value;
        emit Transfer(address(0), owmer, value);
    }

    // 总供应量
    function totalSupply() external view returns (uint256){
        return _totalSupply;
    }
    function balanceOf(address account) external view returns (uint256){
        return _balances[account];
    }
    function allowance(address owner, address spender) external view returns (uint256){
        require(address(0) != owner && address(0) != spender, 'invalid address');
        return _allowances[owner][spender];
    }

    function transfer(address to, uint256 value) external returns (bool){
        require(address(0) != to, 'invalid address');
        require(_balances[msg.sender] >= value, 'you no balance');
        _balances[msg.sender] -= value;
        _balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    // 授权
     function approve(address spender, uint256 value) external returns (bool){
        require(address(0) != spender, 'invalid address');
        _allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
     }
     // 代扣转账
     function transferFrom(address from, address to, uint256 value) external returns (bool){
        require(address(0) != from && address(0) != to, 'invalid address');
        require(value >0, 'value must >0');
        // 授权额度查询
        require(_allowances[from][msg.sender] >= value, '_allowances no balance');
        require(_balances[from] >= value, 'from addr no balance');
        _allowances[from][msg.sender] -= value;
        _balances[from] -= value;
        _balances[to] += value;
        emit Transfer(from, to, value);
        return true;
     } 

}