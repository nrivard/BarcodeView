import XCTest
@testable import BarcodeView

final class UPCATests: XCTestCase {

    func testUPCA() {
        let upc = BarcodeFactory.barcode(from: "302993918288")
        let digits = upc?.digits
        
        XCTAssertNotNil(upc, "Should have been valid UPCA")
        XCTAssertTrue(upc is UPCA, "Should have been UPCA")
        XCTAssertTrue(digits?.count == 15, "Should have been 12 digits, 2 endcaps, and a middle.")
        XCTAssertTrue(digits?.first == .endcap)
        XCTAssertTrue(digits?.last == .endcap)
        XCTAssertTrue(digits?[7] == .middle)
        XCTAssertTrue(digits?[1] == .odd(3))
        XCTAssertTrue(digits?[13] == .even(8))
    }
    
    func testInvalidUPCA() {
        XCTAssertNil(BarcodeFactory.barcode(from: "01234"), "Insufficient digits provided, should have been nil.")
        XCTAssertNil(BarcodeFactory.barcode(from: "122222333334"), "Checksum digit failure")
    }
    
    func testUPCAValue() {
        let value = "012345678901"
        let upc = BarcodeFactory.barcode(from: value, verifyChecksum: false)
        
        XCTAssertTrue(upc?.value == value, "Couldn't generate proper value")
    }
}
