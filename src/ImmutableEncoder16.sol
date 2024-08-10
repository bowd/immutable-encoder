// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8;

contract ImmutableEncoder16 {
    bytes32 private immutable slot0;
    bytes32 private immutable slot1;
    bytes32 private immutable slot2;
    bytes32 private immutable slot3;
    bytes32 private immutable slot4;
    bytes32 private immutable slot5;
    bytes32 private immutable slot6;
    bytes32 private immutable slot7;
    bytes32 private immutable slot8;
    bytes32 private immutable slot9;
    bytes32 private immutable slot10;
    bytes32 private immutable slot11;
    bytes32 private immutable slot12;
    bytes32 private immutable slot13;
    bytes32 private immutable slot14;
    bytes32 private immutable slot15;
    uint256 private immutable dataLength;
    uint8 constant SLOTS = 16;
    uint32 constant BYTES = uint32(SLOTS) * 32;

    constructor(bytes memory data) {
        if (data.length > BYTES) revert("ImmutableHelper: data too large");
        dataLength = data.length;
        // XXX This is probably not necesary, it doesn't matter
        // if we encode junk at the end (and there probably isn't at this point)
        // as long as we decode only the length we'll cut it, but padding feels
        // safer.
        bytes memory dataFullLength = new bytes(BYTES);
        for (uint256 i = 0; i < data.length; i++) {
            dataFullLength[i] = data[i];
        }

        bytes32[] memory slots;
        assembly {
            mstore(dataFullLength, SLOTS)
            slots := dataFullLength
        }

        slot0 = slots[0];
        slot1 = slots[1];
        slot2 = slots[2];
        slot3 = slots[3];
        slot4 = slots[4];
        slot5 = slots[5];
        slot6 = slots[6];
        slot7 = slots[7];
        slot8 = slots[8];
        slot9 = slots[9];
        slot10 = slots[10];
        slot11 = slots[11];
        slot12 = slots[12];
        slot13 = slots[13];
        slot14 = slots[14];
        slot15 = slots[15];
    }

    function params() internal view returns (bytes memory) {
        bytes memory data;
        bytes32[] memory slots = new bytes32[](SLOTS);
        slots[0] = slot0;
        slots[1] = slot1;
        slots[2] = slot2;
        slots[3] = slot3;
        slots[4] = slot4;
        slots[5] = slot5;
        slots[6] = slot6;
        slots[7] = slot7;
        slots[8] = slot8;
        slots[9] = slot9;
        slots[10] = slot10;
        slots[11] = slot11;
        slots[12] = slot12;
        slots[13] = slot13;
        slots[14] = slot14;
        slots[15] = slot15;

        uint256 _dataLength = dataLength;

        assembly {
            mstore(slots, _dataLength)
            data := slots
        }

        return data;
    }
}
