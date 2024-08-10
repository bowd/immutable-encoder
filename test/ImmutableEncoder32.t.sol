// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ImmutableEncoder32} from "src/ImmutableEncoder32.sol";

struct Params {
    string test;
    address[] addrs;
    bool isFunky;
}

contract Example is ImmutableEncoder32 {
    constructor(Params memory params) ImmutableEncoder32(abi.encode(params)) {}

    function getParams() public view returns (Params memory) {
        return abi.decode(params(), (Params));
    }
}

contract ImmutableEncoder32Test is Test {
    Example example;
    Params params;

    function setUp() public {
        address[] memory addrs = new address[](20);
        for (uint256 i = 0; i < addrs.length; i++) {
            addrs[i] = address(uint160(10 + i));
        }
        params = Params("Test", addrs, true);
        console.logBytes(abi.encode(params));
        console.log(abi.encode(params).length);
        example = new Example(params);
    }

    function test_getParams() public view {
        Params memory saved = example.getParams();
        assertEq(saved.isFunky, params.isFunky);
        assertEq(saved.test, params.test);
        assertEq(saved.addrs.length, params.addrs.length);
        for (uint256 i = 0; i < params.addrs.length; i++) {
            assertEq(saved.addrs[i], params.addrs[i]);
        }
    }
}
