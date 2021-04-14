//
//  BarcodeTextView.swift
//  
//
//  Created by Nate Rivard on 05/12/2019.
//

import SwiftUI

struct BarcodeTextView: View {
    private let barcode: Barcode
    private let landmarks: BarcodeLandmarkPreference.Landmarks
    private let height: CGFloat
    private let proxy: GeometryProxy

    init(_ barcode: Barcode, landmarks: BarcodeLandmarkPreference.Landmarks, height: CGFloat, proxy: GeometryProxy) {
        self.barcode = barcode
        self.landmarks = landmarks
        self.height = height
        self.proxy = proxy
    }

    var body: some View {
        let centerLeadingGroupFrame = landmarks.centerLeadingGroupFrame(in: proxy, textHeight: height)
        let centerTrailingGroupFrame = landmarks.centerTrailingGroupFrame(in: proxy, textHeight: height)

        Group {
            BarcodeLabel(barcode.centerLeadingGroup)
                .offset(x: centerLeadingGroupFrame.origin.x, y: centerLeadingGroupFrame.origin.y)
                .frame(width: centerLeadingGroupFrame.size.width, height: centerLeadingGroupFrame.size.height)

            BarcodeLabel(barcode.centerTrailingGroup)
                .offset(x: centerTrailingGroupFrame.origin.x, y: centerTrailingGroupFrame.origin.y)
                .frame(width: centerTrailingGroupFrame.size.width, height: centerTrailingGroupFrame.size.height)
        }
    }
}

struct BarcodeLabel: View {
    private let value: String
    @Environment(\.barWidth) private var barWidth: CGFloat

    init(_ value: String) {
        self.value = value
    }

    var body: some View {
        Text(verbatim: value)
            .font(font)
            .accessibility(hidden: true)
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .anchorPreference(key: HeightPreference.self, value: .bounds) {
                            proxy[$0].height
                        }
                }
            )
    }

    /// creates an appropriately sized font for the current `barWidth`.
    private var font: Font {
        if barWidth > 1 {
            return Font.body.monospacedDigit()
        } else {
            return Font.system(size: 12).monospacedDigit()
        }
    }
}
