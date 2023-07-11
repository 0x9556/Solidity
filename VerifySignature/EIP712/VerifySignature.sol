// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract VerifySignature {
    bytes32 private constant EIP712DOMAIN_TYPEHASH =
        keccak256(
            "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
        );

    bytes32 private constant MESSAGE_TYPEHASH =
        keccak256("Message(string message,uint256 value)");

    bytes32 private DOMAIN_SEPERATOR;

    uint256 public number;
    address private owner;

    constructor(address _owner) {
        DOMAIN_SEPERATOR = keccak256(
            abi.encode(
                EIP712DOMAIN_TYPEHASH,
                keccak256(bytes("VerifySig")),
                keccak256(bytes("1")),
                1,
                address(this)
            )
        );
        owner = _owner;
    }

    function permitApprove(
        uint256 _number,
        bytes memory signature
    ) external returns (address signer) {
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
                DOMAIN_SEPERATOR,
                keccak256(
                    abi.encode(MESSAGE_TYPEHASH, keccak256(bytes("hello")), 100)
                )
            )
        );

        signer = ecrecover(digest, v, r, s);

        require(signer == owner, "INVALID SIGNATURE");
        number = _number;
    }
}
