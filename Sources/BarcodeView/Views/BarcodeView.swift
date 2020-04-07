//
//  BarcodeView.swift
//  
//
//  Created by Nate Rivard on 04/12/2019.
//

import SwiftUI

public struct BarcodeView: View {

    private let barcode: Barcode

    @State private var showText: Bool
    @Environment(\.barWidth) private var barWidth: CGFloat

    public init(_ barcode: Barcode, showText: Bool = true) {
        self.barcode = barcode
        self._showText = State(initialValue: showText)
    }

    public var body: some View {
        BarcodeBarView(digits: barcode.digits)
            .accessibility(addTraits: accessibilityTraits)
            .accessibility(value: Text(verbatim: barcode.value))
            .accessibility(label: Text(barcode.accessibilityLabel))
            .overlay(
                Group {
                    if self.showText {
                        BarcodeTextView(self.barcode)
                    }
                }
                .offset(x: 0, y: barWidth > 1 ? 20 : 14),
                alignment: .bottom
            )
    }
}

extension BarcodeView {

    private var accessibilityTraits: AccessibilityTraits {
        var traits: AccessibilityTraits = .isImage

        if showText {
            let _ = traits.insert(.isStaticText)
        }

        return traits
    }
}
