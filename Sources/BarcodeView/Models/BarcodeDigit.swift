//
//  BarcodeDigit.swift
//  
//
//  Created by Nate Rivard on 10/17/19.
//

import Foundation

public enum BarcodeDigit {

    /// lefthand side odd parity digit
    case odd(Int)

    /// righthand side even parity digit
    case even(Int)

    /// EAN13 specific pattern digit
    case global(Int)

    /// start or end
    case endcap

    /// middle, breaking up the left and right sides
    case middle
}

extension BarcodeDigit {

    typealias BarRepresentation = [Bool]

    func representation() throws -> BarRepresentation {
        switch self {
        case .even(let value):
            return try evenRepresentation(value)
        case .odd(let value):
            return try oddRepresentation(value)
        case . global(let value):
            return try globalRepresentation(value)
        case .endcap:
            return [.black, .white, .black]
        case .middle:
            return [.white, .black, .white, .black, .white]
        }
    }

    /// odd representations have odd black bar width
    private func oddRepresentation(_ value: Int) throws -> BarRepresentation {
        switch value {
        case 0:
            return [.white, .white, .white, .black, .black, .white, .black]
        case 1:
            return [.white, .white, .black, .black, .white, .white, .black]
        case 2:
            return [.white, .white, .black, .white, .white, .black, .black]
        case 3:
            return [.white, .black, .black, .black, .black, .white, .black]
        case 4:
            return [.white, .black, .white, .white, .white, .black, .black]
        case 5:
            return [.white, .black, .black, .white, .white, .white, .black]
        case 6:
            return [.white, .black, .white, .black, .black, .black, .black]
        case 7:
            return [.white, .black, .black, .black, .white, .black, .black]
        case 8:
            return [.white, .black, .black, .white, .black, .black, .black]
        case 9:
            return [.white, .white, .white, .black, .white, .black, .black]
        default:
            throw Error.invalidDigit
        }
    }

    /// even representations have even black bar width
    private func evenRepresentation(_ value: Int) throws -> BarRepresentation {
        // underneath, even reps are a simple inversion of odd reps
        return try oddRepresentation(value).map { !$0 }
    }

    /// global representations are used in the leading group in EAN13 barcodes
    private func globalRepresentation(_ value: Int) throws -> BarRepresentation {
        switch value {
        case 0:
            return [.white, .black, .white, .white, .black, .black, .black]
        case 1:
            return [.white, .black, .black, .white, .white, .black, .black]
        case 2:
            return [.white, .white, .black, .black, .white, .black, .black]
        case 3:
            return [.white, .black, .white, .white, .white, .white, .black]
        case 4:
            return [.white, .white, .black, .black, .black, .white, .black]
        case 5:
            return [.white, .black, .black, .black, .white, .white, .black]
        case 6:
            return [.white, .white, .white, .white, .black, .white, .black]
        case 7:
            return [.white, .white, .black, .white, .white, .white, .black]
        case 8:
            return [.white, .white, .white, .black, .white, .white, .black]
        case 9:
            return [.white, .white, .black, .white, .black, .black, .black]
        default:
            throw Error.invalidDigit
        }
    }
}

extension BarcodeDigit {

    enum Error: Swift.Error {
        case invalidDigit
    }
}

extension BarcodeDigit: Equatable {
 
    public static func ==(lhs: BarcodeDigit, rhs: BarcodeDigit) -> Bool {
        switch (lhs, rhs) {
        case (.endcap, .endcap), (.middle, .middle):
            return true
        case (.odd(let lValue), .odd(let rValue)), (.even(let lValue), .even(let rValue)), (.global(let lValue), .global(let rValue)):
            return lValue == rValue
        default:
            return false
        }
    }
}

extension Bool {

    public static let white = false
    public static let black = true
}
