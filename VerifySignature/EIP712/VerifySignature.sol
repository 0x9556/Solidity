// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract VerifySignature {
    bytes32 private constant EIP712DOMIN_TYPEHASH =
        keccak256(
            "EIP712Domin(string name,string version,uint256 chainId,address verifyingContract)"
        );

    bytes32 private constant APPROVE_TYPEHASH =
        keccak256("Approve(address spender,uint256 value)");

    bytes32 private DOMIN_SEPERATOR;

    address private owner;
    uint public number;

    constructor() {
        DOMIN_SEPERATOR = keccak256(
            abi.encode(
                EIP712DOMIN_TYPEHASH,
                keccak256(bytes("EIP712")),
                keccak256(bytes("1")),
                block.chainid,
                address(this)
            )
        );
        owner = msg.sender;
    }

    function permitApprove(uint value, bytes memory signature) external {
        require(signature.length == 65, "INVALID SIGNATURE LENGTH");
        bytes32 r;
        bytes32 s;
        uint8 v;
        assembly {
            r := mload(add(signature, 0x20))
            s := mload(add(signature, 0x40))
            v := byte(0, mload(add(signature, 0x60)))
        }

        bytes32 digest = keccak256(
            abi.encodePacked(
                "\x19\x01",
                DOMIN_SEPERATOR,
                keccak256(abi.encode(APPROVE_TYPEHASH, address(this), value))
            )
        );

        address signer = ecrecover(digest, v, r, s);

        require(signer == msg.sender, "INVALID SIGNATURE");
        number = value;
    }
}
