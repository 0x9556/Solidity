// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract VerifySignature {
    bytes32 constant EIP712Domin_TypeHash =
        keccak256(
            "EIP712Domin(string name,string version,uint256 chainId,address verifyingContract)"
        );

    bytes32 constant Approve_TypeHash
}
