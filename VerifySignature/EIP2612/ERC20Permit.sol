// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;


contract ERC20Permit  {
    mapping(address => uint) private _nonces;

    bytes32 private immutable DOMAIN_TYPEHASH =
        keccak256(
            "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
        );

    bytes32 private immutable PERMIT_TYPEHASH =
        keccak256(
            "Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"
        );

    bytes32 private immutable DOMAIN_SEPARATOR;

    bool public approved;

    constructor(string memory name) {
        DOMAIN_SEPARATOR = keccak256(
            abi.encode(
                DOMAIN_TYPEHASH,
                keccak256(bytes(name)),
                keccak256(bytes("1")),
                31337,
                address(0x5FbDB2315678afecb367f032d93F642f64180aa3)
            )
        );
    }

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external {
        bytes32 structHash = keccak256(
            abi.encode(
                PERMIT_TYPEHASH,
                owner,
                spender,
                value,
                useNonce(owner),
                deadline
            )
        );

        bytes32 messageHash = keccak256(
            abi.encodePacked("\x19\x01", DOMAIN_SEPARATOR, structHash)
        );

        address signer = ecrecover(messageHash, v, r, s);

        require(signer == owner, "NOT OWNER");

        approved = true;
    }

    function useNonce(address owner) private returns (uint nonce) {
        nonce = _nonces[owner];
        _nonces[owner] += 1;
    }
}
