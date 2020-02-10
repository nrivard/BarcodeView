import XCTest
@testable import BarcodeView

final class BarcodeDigitTests: XCTestCase {

    func testOddParity() {
        for value in 0...9 {
            guard let representation = try? BarcodeDigit.odd(value).representation() else {
                XCTFail("Couldn't generate representation for \(value)")
                continue
            }

            let blackCount = representation.filter({ $0 }).count
            XCTAssert(blackCount % 2 == 1, "Wrong parity for \(value). Should be odd but found \(blackCount)")
        }
    }

    func testEventParity() {
        for value in 0...9 {
            guard let representation = try? BarcodeDigit.even(value).representation() else {
                XCTFail("Couldn't generate representation for \(value)")
                continue
            }

            let blackCount = representation.filter({ $0 }).count
            XCTAssert(blackCount % 2 == 0, "Wrong parity for \(value). Should be even but found \(blackCount)")
        }
    }

    func testGlobalParity() throws {
        for value in 0...9 {
            let representation = try BarcodeDigit.global(value).representation()
            let blackCount = representation.filter({ $0 }).count
            XCTAssertTrue(blackCount % 2 == 0, "Wrong parity for \(value). Should be even but found \(blackCount)")
        }
    }

    func testSpecialDigits() throws {
        let middle = try BarcodeDigit.middle.representation()
        XCTAssert(middle.count == 5, "Middle should have 5 modules")

        let endcap = try BarcodeDigit.endcap.representation()
        XCTAssert(endcap.count == 3, "Endcaps should have 3 modules")
    }

    func testInvalidEquality() {
        XCTAssertFalse(BarcodeDigit.even(1) == BarcodeDigit.odd(1), "Different representation types should not be equal")
    }

    func testInvalidDigits() {
        XCTAssertThrowsError(try BarcodeDigit.even(10).representation())
        XCTAssertThrowsError(try BarcodeDigit.odd(-1).representation())
        XCTAssertThrowsError(try BarcodeDigit.global(1000).representation())
    }
}
