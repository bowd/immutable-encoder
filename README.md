## ImmutableEncoder{8,16,32}

We all love immutable types in Solidity. I mean, variables inlined in the bytecode at construction time, that's wild!
But being limited to only value types can suck at times - maybe you want the flexibility of an array of addresses, a struct or god-forbid a string.
Well, look no further! ImmutableEncoder{8,16,32} gives you the full range of solidity types with the gas efficiency of immutable variables.

### How, you ask?

Well nothing amazing. We declare a bunch (i.e. 8, 16 or 32) of `immutable bytes32 slotXX` which will act as a continous memory location supporting max 256, 512 and 1024 bytes respectively. 
We `abi.encode` a struct that we want to write into a `bytes` type that we pad to the full length of the memory location. 
We, quite frankly, dangerously cast `bytes` to `bytes32[]` by modifying it's memory structure in assembly, because we like living dangerously.
We save each element of the `bytes32[]` array into the `slotXX` immutable variables. 
Later on, we revers this by creating a `bytes32[]` from the `slotXX` immutable variables, we assembly-foo it into a `bytes` type and then `abi.decode` the hell out of that struct.

### Why, you ask?

For science.

### So, what's the scoop?

| Slots   | Decode Gas Cost |
|---------|-----------------|
| 8       | ~2200           |
| 16      | ~4500           |
| 32      | ~9000           |

## Usage

### Install

```bash
forge install bowd/immutable-encoder

```

### Usage with pre-defined encoder sizes

There are 3 pre-defined encoder sizes with 8, 16 and 32 slots, that can be used directly.

```solidity
// Example with struct
struct Params {
    string test;
    address[] addrs;
    bool isFunky;
}

contract Example is ImmutableEncoder16 {
    constructor(Params memory params) ImmutableEncoder16(abi.encode(params)) {}

    function doSomething() {
      Params memory params = getParams();
      // ...
    }

    function getParams() internal view returns (Params memory) {
        return abi.decode(getEncodedBytes(), (Params));
    }
}
```

### Usage with custom slot sizes

You can generate a custom encoder with your own size using the provided script.

```bash
$ ./lib/immutable-encoder/bin/gen-encoder.sh <slots>
```

This will create an `ImmutableEncoder${slots}.sol` file locally that you can then import and use in the same way.
