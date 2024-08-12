// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8;

abstract contract ImmutableEncoder {
    error DataTooLarge(uint256 available, uint256 requested);

    uint256 private immutable storedDataBytes;
    uint256 private immutable slotsCount;
    uint256 private immutable availableDataBytes;

    constructor(uint8 _slotsCount, uint256 dataLength) {
        slotsCount = _slotsCount;
        availableDataBytes = slotsCount * 32;

        storedDataBytes = dataLength;
        if (storedDataBytes > availableDataBytes) {
            revert DataTooLarge(availableDataBytes, storedDataBytes);
        }
    }

    function readSlots() internal view virtual returns (bytes32[] memory);

    function getEncodedBytes() internal view returns (bytes memory data) {
        return bytes32ArrayToBytes(readSlots());
    }

    function bytesToBytes32Array(
        bytes memory data
    ) internal view returns (bytes32[] memory slots) {
        uint256 _slotsCount = slotsCount;
        assembly {
            mstore(data, _slotsCount)
            slots := data
        }
    }

    function bytes32ArrayToBytes(
        bytes32[] memory slots
    ) internal view returns (bytes memory data) {
        assert(slots.length == slotsCount);
        uint256 _storedDataBytes = storedDataBytes;
        assembly {
            mstore(slots, _storedDataBytes)
            data := slots
        }
    }
}
