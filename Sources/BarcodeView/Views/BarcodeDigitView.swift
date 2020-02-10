//
//  BarcodeDigitView.swift
//  
//
//  Created by Nate Rivard on 10/17/19.
//

import SwiftUI

struct BarcodeDigitView: View {

    @State var bars: BarcodeDigit.BarRepresentation
    @Environment(\.barWidth) var barWidth: CGFloat

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<bars.count) { index in
                Group {
                    if self.bars[index] == .black {
                        Rectangle().fill()
                    } else {
                        Spacer()
                    }
                }
                .frame(width: self.barWidth)
            }
        }
    }
}
