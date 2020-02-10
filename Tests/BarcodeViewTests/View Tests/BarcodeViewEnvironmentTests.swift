import SwiftUI
import XCTest
@testable import BarcodeView

final class BarcodeViewEnvironmentTests: XCTestCase {

    func testEnvironmentValues() {
        var values = EnvironmentValues()

        XCTAssertEqual(values.barWidth, BarWidthEnvironmentKey.defaultValue)

        values.barWidth = 4

        let environnment = values[BarWidthEnvironmentKey.self]
        XCTAssertEqual(environnment, 4)
    }
}
