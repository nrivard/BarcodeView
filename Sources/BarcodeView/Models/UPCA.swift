//
//  UPCA.swift
//  
//
//  Created by Nate Rivard on 06/12/2019.
//

import Foundation

/// A UPCA value
public struct UPCA: Barcode {

    /// the underlying calculated digits
    public let digits: [BarcodeDigit]
    public let value: String

    public init?(value: String, verifyChecksum: Bool) {
        guard !verifyChecksum || UPCA.verifyChecksumDigit(value: value), let digits = UPCA.digits(value: value) else { return nil }

        self.digits = digits
        self.value = value
    }
}

extension UPCA {

    private static func digits(value: String) -> [BarcodeDigit]? {
        var digits: [BarcodeDigit] = [.endcap]

        for (index, digit) in value.enumerated() {
            if index == 6 {
                digits.append(.middle)
            }

            guard let digitValue = Int("\(digit)") else { return nil }
            digits.append(index < 6 ? .odd(digitValue) : .even(digitValue))
        }

        digits.append(.endcap)

        return digits
    }

    private static func verifyChecksumDigit(value: String) -> Bool {
        let digits = value.map { Int(String($0))! }.dropLast()

        let odd = stride(from: 0, to: digits.count, by: 2).map { digits[$0] }.reduce(0, +) * 3
        let even = stride(from: 1, to: digits.count, by: 2).map { digits[$0] }.reduce(0, +)

        let calculatedChecksum = 10 - ((odd + even) % 10)

        return String(calculatedChecksum) == value.last.map({ String($0) })
    }
}

extension UPCA: BarcodeDisplaying {

    public var accessibilityLabel: String {
        return "UPCA product code"
    }
}
