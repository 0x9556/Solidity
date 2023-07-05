// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract Target {
    address public lib;
    address public owner;
    uint public number;

    constructor(address _lib) {
        lib = _lib;
    }

    function changeNumber(uint _num) public {
        (bool success, ) = lib.delegatecall(
            abi.encodeWithSignature("changeNumber(uint256)", _num)
        );
        require(success, "delegatecall failed");
    }
}
