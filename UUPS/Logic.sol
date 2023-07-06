// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract LogicOld {
    address public implementation;
    address public owner;
    string public flag;

    function foo() external {
        flag = "old";
    }

    function upgrade(address newImplementation) public {
        require(msg.sender == owner, "NOT OWNER");
        implementation = newImplementation;
    }
}

contract LogicNew {
    address public implementation;
    address public owner;
    string public flag;

    function foo() external {
        flag = "new";
    }

    function upgrade(address newImplementation) public {
        require(msg.sender == owner, "NOT OWNER");
        implementation = newImplementation;
    }
}
