import XCTest
@testable import BarcodeView

final class EAN13Tests: XCTestCase {

    func testEAN13() {
        let upc = BarcodeFactory.barcode(from: "5099902988016")
        let digits = upc?.digits

        XCTAssertNotNil(upc, "Should have been a valid EAN13 code")
        XCTAssertTrue(upc is EAN13, "Should have been of type EAN13")
        XCTAssertTrue(digits?.count == 15, "Should have been 12 digits, 2 endcaps and a middle. 13th digit is pattern index")
        XCTAssertTrue(digits?.first == .endcap)
        XCTAssertTrue(digits?.last == .endcap)
        XCTAssertTrue(digits?[7] == .middle)
        XCTAssertTrue(digits?[13] == .even(6))

        // check pattern
        XCTAssertTrue(digits?[1] == .odd(0), "Incorrect pattern")
        XCTAssertTrue(digits?[2] == .global(9), "Incorrect pattern")
        XCTAssertTrue(digits?[3] == .global(9), "Incorrect pattern")
        XCTAssertTrue(digits?[4] == .odd(9), "Incorrect pattern")
        XCTAssertTrue(digits?[5] == .odd(0), "Incorrect pattern")
        XCTAssertTrue(digits?[6] == .global(2), "Incorrect pattern")
    }

    func testInvalidEAN13() {
        XCTAssertNil(BarcodeFactory.barcode(from: "01234"), "Insufficient digits provided, should have been nil.")
        XCTAssertNil(BarcodeFactory.barcode(from: "9122222333334"), "Checksum digit failure")
        XCTAssertNil(EAN13(value: "", verifyChecksum: false))
    }

    func testEAN13Value() {
        let value = "0123456789012"
        let upc = BarcodeFactory.barcode(from: value, verifyChecksum: false)

        XCTAssertTrue(upc?.value == value, "Couldn't generate proper value")
    }
}
