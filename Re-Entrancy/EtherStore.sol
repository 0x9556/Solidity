// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract EtherStore {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        assert(msg.value > 0);
        balances[msg.sender] = balances[msg.sender] + msg.value;
    }

    function withdraw(uint256 amount) external {
        uint256 balance = balances[msg.sender];
        require(amount <= balance, "InvalidAmount");
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "TransferFailded");
        balances[msg.sender] = balance - amount;
    }

    function getReserve() external view returns (uint256) {
        return address(this).balance;
    }
}
