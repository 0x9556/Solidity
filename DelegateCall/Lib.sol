// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract Lib {
    uint public number;

    function changeNumber(uint _num) external {
        number = _num;
    }
}
