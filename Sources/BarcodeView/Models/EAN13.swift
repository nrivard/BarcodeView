//
//  EAN13.swift
//  
//
//  Created by Nate Rivard on 06/12/2019.
//

import Foundation

public struct EAN13: Barcode {

    public let digits: [BarcodeDigit]
    public let value: String

    public init?(value: String, verifyChecksum: Bool) {
        guard !verifyChecksum || EAN13.verifyChecksumDigit(value: value), let digits = EAN13.digits(value: value) else { return nil }

        self.digits = digits
        self.value = value
    }
}

extension EAN13 {

    /// EAN13 leading group patterns indexed by the first digit of the barcode.
    /// NOTE: the values contained in the digits have dummy values and should be replaced when filling out the real digits
    private static let patterns: [Int: [BarcodeDigit]] = [
        0: [.odd(0), .odd(0), .odd(0), .odd(0), .odd(0), .odd(0)],
        1: [.odd(0), .odd(0), .global(1), .odd(0), .global(1), .global(1)],
        2: [.odd(0), .odd(0), .global(1), .global(1), .odd(0), .global(1)],
        3: [.odd(0), .odd(0), .global(1), .global(1), .global(1), .odd(0)],
        4: [.odd(0), .global(1), .odd(0), .odd(0), .global(1), .global(1)],
        5: [.odd(0), .global(1), .global(1), .odd(0), .odd(0), .global(1)],
        6: [.odd(0), .global(1), .global(1), .global(1), .odd(0), .odd(0)],
        7: [.odd(0), .global(1), .odd(0), .global(1), .odd(0), .global(1)],
        8: [.odd(0), .global(1), .odd(0), .global(1), .global(1), .odd(1)],
        9: [.odd(0), .global(1), .global(1), .odd(0), .global(1), .odd(0)]
    ]

    private static func digits(value: String) -> [BarcodeDigit]? {
        guard let firstChar = value.first,
            let patternIndex = Int(String(firstChar)),
            let pattern = EAN13.patterns[patternIndex] else
        {
            return nil
        }

        var digits: [BarcodeDigit] = [.endcap]
        let digitValues = value.dropFirst().map { Int(String($0))! }

        // leading group
        for (index, type) in pattern.enumerated() {
            switch type {
            case .odd:
                digits.append(.odd(digitValues[index]))
            case .global:
                digits.append(.global(digitValues[index]))
            default:
                return nil
            }
        }

        digits.append(.middle)

        (digitValues[6..<digitValues.count]).forEach {
            digits.append(.even($0))
        }

        digits.append(.endcap)

        return digits
    }
    
    private static func verifyChecksumDigit(value: String) -> Bool {
        let digits = value.compactMap { Int(String($0)) }
        let lastDigit = digits.last!
        
        let evenSum = stride(from: 1, to: digits.count - 1, by: 2).map { digits[$0] }.reduce(0, +) * 3
        let oddSum = stride(from: 0, to: digits.count - 1, by: 2).map { digits[$0] }.reduce(0, +)
        let totalSum = evenSum + oddSum
    
        let calculatedCheckDigit = totalSum % 10 == 0 ? 0 : 10 - totalSum % 10
    
        return calculatedCheckDigit == lastDigit
    }
}

extension EAN13: BarcodeDisplaying {

    /// override `BarcodeDisplaying` checksum to not display it
    public var checksumDigit: String {
        return ""
    }

    public var accessibilityLabel: String {
        return "EAN13 product code"
    }
}
