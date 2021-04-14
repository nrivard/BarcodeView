import XCTest
import ViewInspector
@testable import BarcodeView

final class BarcodeViewTests: XCTestCase {

    static let value = "123456789012"
    static let upc = BarcodeFactory.barcode(from: BarcodeViewTests.value, verifyChecksum: false)!

    func testUPCBarView() throws {
        // TODO: getting an error on barcode bar view due to the overlay preference modifier :shrug:
//        XCTAssertNoThrow(
//            try BarcodeView(BarcodeViewTests.upc)
//                .inspect()
//                .hStack()
//                .view(BarcodeBarView.self, 1)
//        )
    }

    func testTextHidden() throws {
        let hstackInspection = try BarcodeView(BarcodeViewTests.upc, showText: false)
            .inspect()
            .hStack()

        XCTAssertThrowsError(try hstackInspection.view(BarcodeLabel.self, 0))
        XCTAssertThrowsError(try hstackInspection.view(BarcodeLabel.self, 2))
    }

    func testTextDisplayed() throws {
        let hstackInspection = try BarcodeView(BarcodeViewTests.upc)
            .inspect()
            .hStack()

        XCTAssertNoThrow(try hstackInspection.view(BarcodeLabel.self, 0))
        XCTAssertNoThrow(try hstackInspection.view(BarcodeLabel.self, 2))
    }
}
