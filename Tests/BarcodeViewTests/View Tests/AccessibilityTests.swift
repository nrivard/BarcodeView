import XCTest
import ViewInspector
@testable import BarcodeView

final class AccessiblityTests: XCTestCase {

    func testUPCAAccessilibity() throws {
        let value = "123456789012"
        let upc = try XCTUnwrap(BarcodeFactory.barcode(from: value, verifyChecksum: false))

        let upcViewInspection = try BarcodeView(upc)
            .inspect()
            .view(BarcodeBarView.self)

        XCTAssertEqual(try upcViewInspection.accessibilityLabel().string(), upc.accessibilityLabel)
        XCTAssertEqual(try upcViewInspection.accessibilityValue().string(), upc.value)
    }

    func testEAN13Accessilibity() throws {
        let value = "1234567890123"
        let upc = try XCTUnwrap(BarcodeFactory.barcode(from: value, verifyChecksum: false))

        let upcViewInspection = try BarcodeView(upc)
            .inspect()
            .view(BarcodeBarView.self)

        XCTAssertEqual(try upcViewInspection.accessibilityLabel().string(), upc.accessibilityLabel)
        XCTAssertEqual(try upcViewInspection.accessibilityValue().string(), upc.value)
    }
}
