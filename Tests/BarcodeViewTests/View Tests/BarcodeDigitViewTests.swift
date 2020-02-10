import XCTest
import ViewInspector
@testable import BarcodeView

final class BarcodeDigitViewTests: XCTestCase {

    func testEndcap() throws {
        try test(digit: .endcap)
    }

    func testMiddle() throws {
        try test(digit: .middle)
    }

    func testOddDigit() throws {
        try test(digit: .odd(5))
    }

    func testEvenDigit() throws {
        try test(digit: .even(5))
    }

    func testGlobalDigit() throws {
        try test(digit: .global(5))
    }

    private func test(digit: BarcodeDigit) throws {
        let bars = try BarcodeDigit.endcap.representation()

        let forEachInspection = try BarcodeDigitView(bars: bars)
            .inspect()
            .hStack()
            .forEach(0)

        XCTAssertEqual(forEachInspection.underestimatedCount, bars.count)

        for index in 0..<forEachInspection.underestimatedCount {
            let groupInspection = try forEachInspection.group(index)

            if bars[index] {
                XCTAssertNoThrow(try groupInspection.shape(0))
            } else {
                XCTAssertNoThrow(try groupInspection.spacer(0))
            }
        }
    }
}
