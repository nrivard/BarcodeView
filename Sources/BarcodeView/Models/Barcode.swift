//
//  Barcode.swift
//
//
//  Created by Nate Rivard on 10/18/19.
//

import Foundation

/// A unique product code
public protocol Barcode: BarcodeDisplaying {

    /// an initializer that creates a `Barcode` via raw String representation
    init?(value: String, verifyChecksum: Bool)

    /// access to underlying `Barcode` digits
    var digits: [BarcodeDigit] { get }

    /// access to the original raw String representation
    var value: String { get }
}

public extension Barcode {

    /// default implementation that regenerates the value via the underlying digits
    var value: String {
        return digits.reduce("") { running, current in
            switch current {
            case .endcap, .middle:
                return running
            case .even(let code), .odd(let code), .global(let code):
                return running + "\(code)"
            }
        }
    }

    var prefix: String {
        return String(value[value.startIndex])
    }

    var centerLeadingGroup: String {
        let startIndex = value.index(after: value.startIndex)
        let endIndex = value.index(startIndex, offsetBy: 5)
        return String(value[startIndex..<endIndex])
    }

    var centerTrailingGroup: String {
        let startIndex = value.index(value.startIndex, offsetBy: 6)
        let endIndex = value.index(startIndex, offsetBy: 5)
        return String(value[startIndex..<endIndex])
    }

    var checksumDigit: String {
        return String(value[value.index(before: value.endIndex)])
    }
}
