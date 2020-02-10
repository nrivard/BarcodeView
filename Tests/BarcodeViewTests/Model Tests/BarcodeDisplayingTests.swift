import XCTest
@testable import BarcodeView

final class BarcodeDisplayingTests: XCTestCase {

    let upc = BarcodeFactory.barcode(from: "122222333334", verifyChecksum: false)

    func testPrefix() {
        XCTAssertEqual(upc?.prefix, "1")
    }

    func testCenterLeadingGroup() {
        XCTAssertEqual(upc?.centerLeadingGroup, "22222")
    }

    func testCenterTrailingGroup() {
        XCTAssertEqual(upc?.centerTrailingGroup, "33333")
    }

    func testChecksumDigit() {
        XCTAssertEqual(upc?.checksumDigit, "4")
    }

    func testChecksumDigitHiddenEAN13() {
        let ean13 = BarcodeFactory.barcode(from: "9122222333334", verifyChecksum: false)
        XCTAssertEqual(ean13?.checksumDigit, "")
    }
}
