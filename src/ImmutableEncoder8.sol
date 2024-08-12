// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8;

import "./ImmutableEncoder.sol";

contract ImmutableEncoder8 is ImmutableEncoder {
    bytes32 private immutable slot0;
    bytes32 private immutable slot1;
    bytes32 private immutable slot2;
    bytes32 private immutable slot3;
    bytes32 private immutable slot4;
    bytes32 private immutable slot5;
    bytes32 private immutable slot6;
    bytes32 private immutable slot7;

    constructor(bytes memory data) ImmutableEncoder(8, data.length) {
        bytes32[] memory slots = bytesToBytes32Array(data);

        slot0 = slots[0];
        slot1 = slots[1];
        slot2 = slots[2];
        slot3 = slots[3];
        slot4 = slots[4];
        slot5 = slots[5];
        slot6 = slots[6];
        slot7 = slots[7];
    }

    function readSlots()
        internal
        view
        override
        returns (bytes32[] memory slots)
    {
        slots = new bytes32[](8);
        slots[0] = slot0;
        slots[1] = slot1;
        slots[2] = slot2;
        slots[3] = slot3;
        slots[4] = slot4;
        slots[5] = slot5;
        slots[6] = slot6;
        slots[7] = slot7;
    }
}
