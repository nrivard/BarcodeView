//
//  BarcodeTextView.swift
//  
//
//  Created by Nate Rivard on 05/12/2019.
//

import SwiftUI

struct BarcodeTextView: View {
    private let barcode: BarcodeDisplaying

    @Environment(\.barWidth) private var barWidth: CGFloat

    init(_ barcode: BarcodeDisplaying) {
        self.barcode = barcode
    }

    var body: some View {
        HStack(spacing: barWidth * 2) {
            Text(verbatim: barcode.prefix).font(font)
                .accessibility(hidden: true)
            
            Spacer()
            
            Text(verbatim: barcode.centerLeadingGroup).font(font)
                .accessibility(hidden: true)
            
            Text(verbatim: barcode.centerTrailingGroup).font(font)
                .accessibility(hidden: true)
            
            Spacer()
            
            Text(verbatim: barcode.checksumDigit).font(font)
                .accessibility(hidden: true)
        }
    }
}

extension BarcodeTextView {

    /// creates an appropriately sized font for the current `barWidth`.
    private var font: Font {
        if barWidth > 1 {
            return Font.body.monospacedDigit()
        } else {
            return Font.system(size: 9).monospacedDigit()
        }
    }
}
