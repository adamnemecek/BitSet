import XCTest
@testable import BitSet

class BitSetTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BitSet<UInt64>().count, 0)

        let a: BitSet<UInt64> = [1,2,3,4]

        XCTAssertEqual(a.contains(1), true)
        XCTAssertEqual(a.contains(6), false)

        XCTAssertEqual(a.count, 4)


        XCTAssert(a.map { $0 }.elementsEqual([1,2,3,4]))
        
//        print(a)

    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
