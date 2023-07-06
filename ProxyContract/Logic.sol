// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract Logic {
    event CallSuccess();

    address public implementation;
    uint256 public x = 99;

    function increment() external returns (uint256) {
        emit CallSuccess();
        return x += 1;
    }
}
