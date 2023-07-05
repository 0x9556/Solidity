// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract EtherStore {
    mapping(address => uint) public balances;

    function deposit() external payable {
        balances[msg.sender] = balances[msg.sender] + msg.value;
    }

    function withdraw(uint amount) external {
        uint balance = balances[msg.sender];
        require(amount <= balance, "InvalidAmount");
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "TransferFailded");
        balances[msg.sender] = balance - amount;
    }

    function getReserve() external view returns (uint) {
        return address(this).balance;
    }
}
