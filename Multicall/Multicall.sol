// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract Multicall {
    struct Call {
        address target;
        bytes callData;
    }

    struct Result {
        bool success;
        bytes returnData;
    }

    error MulticallFaild(uint256 index);

    function aggregate(Call[] calldata calls)
        external
        returns (Result[] memory returnData)
    {
        uint256 length = calls.length;
        returnData = new Result[](length);
        for (uint256 i = 0; i < length; ) {
            Result memory result = returnData[i];
            (result.success, result.returnData) = calls[i].target.call(
                calls[i].callData
            );
            if (!result.success) revert MulticallFaild(i);
            unchecked {
                i++;
            }
        }
    }

    //0x40c10f19000000000000000000000000dd870fa1b7c4700f2bd7f44238821c26f73921480000000000000000000000000000000000000000000000000000000000000064
    //0x40c10f19000000000000000000000000583031d1113ad414f02576bd6afabfb3021402250000000000000000000000000000000000000000000000000000000000000064
}
