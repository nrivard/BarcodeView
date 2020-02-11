//
//  BarcodeDigitView.swift
//  
//
//  Created by Nate Rivard on 10/17/19.
//

import SwiftUI

struct BarcodeDigitView: Shape {

    @State var bars: BarcodeDigit.BarRepresentation
    @Environment(\.barWidth) var barWidth: CGFloat

    func path(in rect: CGRect) -> Path {
        var  path = Path()

        let size: CGSize = .init(width: barWidth, height: rect.height)

        let rects = bars
            .enumerated()
            .filter { $0.1 }
            .map { CGRect(origin: .init(x: barWidth * CGFloat($0.0), y: 0), size: size) }

        path.addRects(rects)

        return path
    }
}
