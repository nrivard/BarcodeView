//
//  File.swift
//  
//
//  Created by Nate Rivard on 06/12/2019.
//

import Foundation

public enum BarcodeFactory {

    public static func barcode(from value: String, verifyChecksum: Bool = true) -> Barcode? {
        switch value.count {
        case 12:
            return UPCA(value: value, verifyChecksum: verifyChecksum)
        case 13:
            return EAN13(value: value, verifyChecksum: verifyChecksum)
        default:
            return nil
        }
    }
}
