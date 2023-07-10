// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;


contract VerifySignature {

    event Log(bytes32 ethSignedHash);

    function verify(
        address _to,
        uint _amount,
        string memory _message,
        uint _nonce,
        address _signer,
        bytes memory _signature
    ) external returns (bool) {
        bytes32 messageHash = getMessageHash(_to, _amount, _message, _nonce);
        bytes32 ethSignedHash = getEthSignedMessage(messageHash);
        emit Log(ethSignedHash);
        return recoverSigner(ethSignedHash, _signature) == _signer;
    }

    function recoverSigner(
        bytes32 _ethSignedHash,
        bytes memory _signature
    ) private pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        return ecrecover(_ethSignedHash, v, r, s);
    }

    function splitSignature(
        bytes memory _signature
    ) private pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(_signature.length == 65, "invalid signature length");
        assembly {
            r := mload(add(_signature, 32))
            s := mload(add(_signature, 64))
            v := byte(0, mload(add(_signature, 96)))
        }
    }

    function getMessageHash(
        address _to,
        uint _amount,
        string memory _message,
        uint _nonce
    ) public pure returns (bytes32) {
        bytes memory data = abi.encodePacked(_to, _amount, _message, _nonce);
        return keccak256(data);
    }

    function getEthSignedMessage(
        bytes32 _messageHash
    ) public pure returns (bytes32) {
        return
            keccak256(
                abi.encodePacked(
                    "\x19Ethereum Signed Message:\n32",
                    _messageHash
                )
            );
    }

    function getMessage(
        address _to,
        uint _amount,
        string memory _message,
        uint _nonce
    ) public pure returns (bytes memory data) {
        data = abi.encodePacked(_to, _amount, _message, _nonce);
    }
}

