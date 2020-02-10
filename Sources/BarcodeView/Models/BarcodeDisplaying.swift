//
//  BarcodeDisplaying.swift
//  
//
//  Created by Nate Rivard on 06/12/2019.
//

import Foundation

/// A barcode meant to be displayed with a leading digit, first group, second group and finally trailing checksum digit
public protocol BarcodeDisplaying {

    /// the full string value of the barcode
    var value: String { get }

    /// leading digit that should be offset from the symbol
    var prefix: String { get }

    /// the leading group of digits around the center symbol, likely the manufacturer code with or without number system
    var centerLeadingGroup: String { get }

    /// the trailing group of digits around the center symbol, likely the product code
    var centerTrailingGroup: String { get }

    /// trailing checksum digit that should be offset from the symbol
    var checksumDigit: String { get }

    /// an accessibility description of this barcode
    var accessibilityLabel: String { get }
}
