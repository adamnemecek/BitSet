# BitSet

hey it's me ur fav datastructure, [BitSet](https://en.wikipedia.org/wiki/Bit_array). This implementation is generic and uses a fixed size unsigned integer as it's backing storage. Yes, you can only store 64 or [128](https://github.com/Jitsusama/UInt128) bits but a lot of times that's enough and this way, it's fast as shit (💩). Uses intrinsics to be fast.

[TRY IT IN YOUR BROWSER](http://swift.sandbox.bluemix.net/#/repl/5a1df029df5afc5405d01f3d)

# Installation
Use Swift Package Manager. 

```swift
import PackageDescription

let package = Package(
    name: "BitSet",
    dependencies: [
      .Package(url: "https://github.com/adamnemecek/BitSet.git", majorVersion: 1)
    ]
)
```

# Usage

```swift
import BitSet

typealias BitSet64 = BitSet<UInt64>

let b: BitSet64 = [1,2,3,4,10]

print(b.count) /// => 5

print(b.contains(1)) /// => true

print(b.contains(11)) /// => false

let c = b.union([20,30]) /// => BitSet([1,2,3,4,10,20,30])

/// BitSet conforms to SetAlgebra and Collection so all your favorite operations are supported.

```

# Documentation

```swift
public struct BitSet<Element: FixedWidthInteger & UnsignedInteger>: SetAlgebra, Collection, ExpressibleByArrayLiteral, CustomStringConvertible, Hashable {
    struct Index {
        /// ...
    }

    var startIndex: Index { get }
    var endIndex: Index { get }
    var count: IndexDistance { get }

    subscript(index: Index) -> Element { get }

    /// and
    func intersection(_ other: BitSet) -> BitSet

    /// or
    func union(_ other: BitSet) -> BitSet

    /// xor
    func symmetricDifference(_ other: BitSet) -> BitSet

}

```
