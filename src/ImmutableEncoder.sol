// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8;

abstract contract ImmutableEncoder {
    error DataTooLarge(uint256 available, uint256 requested);

    uint256 private immutable storedDataBytesLength;
    uint8 immutable slotsCount;
    uint32 immutable availableDataBytesLength;

    constructor(uint8 _slotsCount, uint256 dataLength) {
        slotsCount = _slotsCount;
        availableDataBytesLength = uint32(slotsCount) * 32;
        storedDataBytesLength = dataLength;
        if (storedDataBytesLength > availableDataBytesLength) {
            revert DataTooLarge(
                availableDataBytesLength,
                storedDataBytesLength
            );
        }
    }

    function readSlots() internal view virtual returns (bytes32[] memory);

    function getEncodedBytes() internal view returns (bytes memory data) {
        return bytes32ArrayToBytes(readSlots());
    }

    function bytesToBytes32Array(
        bytes memory data
    ) internal view returns (bytes32[] memory slots) {
        uint256 _slotsCount = uint256(slotsCount);
        assembly {
            mstore(data, _slotsCount)
            slots := data
        }
        return slots;
    }

    function bytes32ArrayToBytes(
        bytes32[] memory slots
    ) internal view returns (bytes memory data) {
        assert(slots.length == slotsCount);
        uint256 _storedDataBytesLength = storedDataBytesLength;

        assembly {
            mstore(slots, _storedDataBytesLength)
            data := slots
        }

        return data;
    }
}
