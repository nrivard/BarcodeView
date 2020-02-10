import XCTest
import ViewInspector
@testable import BarcodeView

final class BarcodeBarViewTests: XCTestCase {

    static let value = "123456789012"
    static let upc = BarcodeFactory.barcode(from: BarcodeBarViewTests.value, verifyChecksum: false)!

    func testDigitViews() throws {
        let digits = BarcodeBarViewTests.upc.digits

        let forEachInspection = try BarcodeBarView(digits: digits)
            .inspect()
            .hStack()
            .forEach(0)

        XCTAssertEqual(forEachInspection.underestimatedCount, digits.count)

        for index in 0..<forEachInspection.underestimatedCount {
            XCTAssertNoThrow(try forEachInspection.view(BarcodeDigitView.self, index))
        }
    }
}
