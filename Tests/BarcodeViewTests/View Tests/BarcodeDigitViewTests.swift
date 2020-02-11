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
        let bars = try digit.representation()

        let path = try BarcodeDigitView(bars: bars)
            .inspect()
            .shape()
            .path(in: .init(x: 0, y: 0, width: CGFloat(bars.count) * BarWidthEnvironmentKey.defaultValue, height: 1))

        bars.enumerated().filter({ $0.1 }).forEach {
            let xOffset = CGFloat($0.0) * BarWidthEnvironmentKey.defaultValue
            let point = CGPoint(x: xOffset, y: 0)
            XCTAssertTrue(path.contains(point))
        }
    }
}
