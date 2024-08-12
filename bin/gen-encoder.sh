#!/usr/bin/env bash
#########################################################
# Usage:
# ./bin/gen-encoder.sh <slots>
# Will write an encoder with <slots> to the "src" folder 
# if found or the current folder.
# #######################################################

TARGET_DIR=$(pwd)

if [ -d "$(pwd)/src" ]; then
  TARGET_DIR=$(pwd)/src
fi

SLOTS=$1

case $SLOTS in
    ''|*[!0-9]*) echo "First argument <slots> should be a number" ; exit 1;
esac

TARGET_FILE=$TARGET_DIR/ImmutableEncoder${SLOTS}.sol

if [ -f $TARGET_FILE ]; then
  echo "$TARGET_FILE exists, stopping."
  exit 1;
fi

if [ -f "src/ImmutableEncoder.sol" ]; then
  BASE_ENCODER_IMPORT="./ImmutableEncoder.sol"
else
  BASE_ENCODER_IMPORT="immutable-encoder/ImmutableEncoder.sol"
fi

cat >> $TARGET_FILE <<-EOM
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8;

import "$BASE_ENCODER_IMPORT";

contract ImmutableEncoder$SLOTS is ImmutableEncoder {
EOM

for ((i=0;i<SLOTS;i++)); do
cat >> $TARGET_FILE <<-EOM
    bytes32 private immutable slot${i};
EOM
done

cat >> $TARGET_FILE <<-EOM

    constructor(bytes memory data) ImmutableEncoder(${SLOTS}, data.length) {
        bytes32[] memory slots = bytesToBytes32Array(data);
EOM

for ((i=0;i<SLOTS;i++)); do
cat >> $TARGET_FILE <<-EOM
        slot${i} = slots[${i}];
EOM
done

cat >> $TARGET_FILE <<-EOM
    }

    function readSlots()
        internal
        view
        override
        returns (bytes32[] memory slots)
    {
        slots = new bytes32[]($SLOTS);
EOM

for ((i=0;i<SLOTS;i++)); do
cat >> $TARGET_FILE <<-EOM
        slots[${i}] = slot${i};
EOM
done

cat >> $TARGET_FILE <<-EOM
    }
}
EOM

