import XCTest
@testable import BitSet

class BitSetTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BitSet<UInt64>().count, 0)

    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
