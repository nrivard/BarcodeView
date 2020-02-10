import XCTest
import ViewInspector
@testable import BarcodeView

final class BarcodeViewTests: XCTestCase {

    static let value = "123456789012"
    static let upc = BarcodeFactory.barcode(from: BarcodeViewTests.value, verifyChecksum: false)!

    func testUPCBarView() throws {
        XCTAssertNoThrow(try BarcodeView(BarcodeViewTests.upc).inspect().view(BarcodeBarView.self))
    }

    func testOverlayEmpty() throws {
        let groupInspection = try BarcodeView(BarcodeViewTests.upc, showText: false)
            .inspect()
            .view(BarcodeBarView.self)
            .overlay()
            .group()

        XCTAssertThrowsError(try groupInspection.view(BarcodeTextView.self, 0))
    }

    func testOverlayUPCTextView() throws {
        let groupInspection = try BarcodeView(BarcodeViewTests.upc)
            .inspect()
            .view(BarcodeBarView.self)
            .overlay()
            .group()

        XCTAssertNoThrow(try groupInspection.view(BarcodeTextView.self, 0))
    }

    func testOverlayOffset() throws {
        let offset = try BarcodeView(BarcodeViewTests.upc)
            .inspect()
            .view(BarcodeBarView.self)
            .overlay()
            .group()
            .offset()

        XCTAssertEqual(offset, CGSize(width: 0, height: 20))

//        let unitBarWidthOffset = ViewHosting.host(view: <#T##View#>)
    }
}
