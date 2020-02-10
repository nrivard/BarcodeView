import XCTest
@testable import BarcodeView

final class BarcodeExtensionTests: XCTestCase {

    private struct MockUPC: Barcode {
        let accessibilityLabel: String = "Mock. yeah. ing. yeah. bird. yeah."

        var digits: [BarcodeDigit]

        init?(value: String, verifyChecksum: Bool) {
            self.digits = [.endcap, .middle, .endcap] + value.map {
                BarcodeDigit.even(Int(String($0))!)
            }
        }
    }

    func testValue() {
        let value = "122222333334"
        let upc = MockUPC(value: value, verifyChecksum: false)
        XCTAssertEqual(upc?.value, value)
    }
}
