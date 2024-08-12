// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ImmutableEncoder8} from "src/ImmutableEncoder8.sol";

struct Params {
    string test;
    bool isFunky;
}

contract Example is ImmutableEncoder8 {
    constructor(Params memory params) ImmutableEncoder8(abi.encode(params)) {}

    function getParams() public view returns (Params memory) {
        return abi.decode(getEncodedData(), (Params));
    }
}

contract ImmutableEncoder8Test is Test {
    Example example;
    Params params;

    function setUp() public {
        params = Params("Test", true);
        console.logBytes(abi.encode(params));
        example = new Example(params);
    }

    function test_getParams() public view {
        Params memory saved = example.getParams();
        assertEq(saved.isFunky, params.isFunky);
        assertEq(saved.test, params.test);
    }
}
