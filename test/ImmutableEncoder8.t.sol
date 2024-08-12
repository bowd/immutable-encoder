// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ImmutableEncoder8} from "src/ImmutableEncoder8.sol";

struct Params {
    address[] addrs;
    bool isFunky;
}

contract Example is ImmutableEncoder8 {
    constructor(Params memory params) ImmutableEncoder8(abi.encode(params)) {}

    function getParams() public view returns (Params memory) {
        return abi.decode(getEncodedBytes(), (Params));
    }
}

contract ImmutableEncoder8Test is Test {
    Example example;
    Params params;

    function setUp() public {
        address[] memory addrs = new address[](3);
        for (uint256 i = 0; i < addrs.length; i++) {
            addrs[i] = address(uint160(10 + i));
        }
        params = Params(addrs, true);
        example = new Example(params);
    }

    function test_dataTooLarge() public {
        address[] memory addrs = new address[](10);
        for (uint256 i = 0; i < addrs.length; i++) {
            addrs[i] = address(uint160(10 + i));
        }
        params = Params(addrs, true);
        vm.expectRevert(
            abi.encodeWithSignature(
                "DataTooLarge(uint256,uint256)",
                8 * 32,
                abi.encode(params).length
            )
        );
        example = new Example(params);
    }

    function test_getParams() public view {
        Params memory saved = example.getParams();
        assertEq(saved.isFunky, params.isFunky);
        assertEq(saved.addrs.length, params.addrs.length);
        for (uint256 i = 0; i < params.addrs.length; i++) {
            assertEq(saved.addrs[i], params.addrs[i]);
        }
    }
}
