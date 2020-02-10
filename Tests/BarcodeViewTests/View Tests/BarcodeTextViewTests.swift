import XCTest
import ViewInspector
@testable import BarcodeView

final class BarcodeTextViewTests: XCTestCase {

    static let value = "123456789012"
    static let upc = BarcodeFactory.barcode(from: BarcodeTextViewTests.value, verifyChecksum: false)!

    func testTextViews() throws {
        let hStackInspection = try BarcodeTextView(BarcodeTextViewTests.upc)
            .inspect()
            .hStack()

        XCTAssertEqual(try hStackInspection.text(0).string(), BarcodeTextViewTests.upc.prefix)
        XCTAssertEqual(try hStackInspection.text(2).string(), BarcodeTextViewTests.upc.centerLeadingGroup)
        XCTAssertEqual(try hStackInspection.text(3).string(), BarcodeTextViewTests.upc.centerTrailingGroup)
        XCTAssertEqual(try hStackInspection.text(5).string(), BarcodeTextViewTests.upc.checksumDigit)
    }

    func testSpacers() throws {
        let hStackInspection = try BarcodeTextView(BarcodeTextViewTests.upc)
            .inspect()
            .hStack()

        XCTAssertNoThrow(try hStackInspection.spacer(1))
        XCTAssertNoThrow(try hStackInspection.spacer(4))
    }

    func testFontSize() throws {
        // TODO: can't actually query and verify `Font` yet, so just verify it doesnt throw and that code is covered is tests
        // TODO: environment value doesn't appear to be piped through. Need to use `ViewHosting.host(_)`
        XCTAssertNoThrow(try BarcodeTextView(BarcodeTextViewTests.upc)
            .environment(\.barWidth, 1)
            .inspect()
            .view(BarcodeTextView.self)
            .hStack()
            .text(0)
        )
    }
}
