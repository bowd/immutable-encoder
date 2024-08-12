// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8;

import "./ImmutableEncoder.sol";

contract ImmutableEncoder32 is ImmutableEncoder {
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
    bytes32 private immutable slot16;
    bytes32 private immutable slot17;
    bytes32 private immutable slot18;
    bytes32 private immutable slot19;
    bytes32 private immutable slot20;
    bytes32 private immutable slot21;
    bytes32 private immutable slot22;
    bytes32 private immutable slot23;
    bytes32 private immutable slot24;
    bytes32 private immutable slot25;
    bytes32 private immutable slot26;
    bytes32 private immutable slot27;
    bytes32 private immutable slot28;
    bytes32 private immutable slot29;
    bytes32 private immutable slot30;
    bytes32 private immutable slot31;

    constructor(bytes memory data) ImmutableEncoder(32, data.length) {
        bytes32[] memory slots = bytesToBytes32Array(data);

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
        slot16 = slots[16];
        slot17 = slots[17];
        slot18 = slots[18];
        slot19 = slots[19];
        slot20 = slots[20];
        slot21 = slots[21];
        slot22 = slots[22];
        slot23 = slots[23];
        slot24 = slots[24];
        slot25 = slots[25];
        slot26 = slots[26];
        slot27 = slots[27];
        slot28 = slots[28];
        slot29 = slots[29];
        slot30 = slots[30];
        slot31 = slots[31];
    }

    function readSlots()
        internal
        view
        override
        returns (bytes32[] memory slots)
    {
        slots = new bytes32[](32);
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
        slots[16] = slot16;
        slots[17] = slot17;
        slots[18] = slot18;
        slots[19] = slot19;
        slots[20] = slot20;
        slots[21] = slot21;
        slots[22] = slot22;
        slots[23] = slot23;
        slots[24] = slot24;
        slots[25] = slot25;
        slots[26] = slot26;
        slots[27] = slot27;
        slots[28] = slot28;
        slots[29] = slot29;
        slots[30] = slot30;
        slots[31] = slot31;
    }
}
