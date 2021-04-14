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
    @State private var textHeight: CGFloat = 0
    @Environment(\.barWidth) private var barWidth: CGFloat

    public init(_ barcode: Barcode, showText: Bool = true) {
        self.barcode = barcode
        self._showText = State(initialValue: showText)
    }

    public var body: some View {
        HStack(alignment: .bottom, spacing: barWidth * 2) {
            if showText {
                BarcodeLabel(barcode.prefix)
                    .alignmentGuide(.bottom, computeValue: { dimension in
                        dimension[.bottom] - (textHeight / 2)
                    })
            }

            BarcodeBarView(digits: barcode.digits)
                .overlayPreferenceValue(BarcodeLandmarkPreference.self) { landmarks in
                    if showText {
                        GeometryReader { proxy in
                            ZStack {
                                BarcodeCutout(landmarks: landmarks, height: textHeight, proxy: proxy)
                                BarcodeTextView(barcode, landmarks: landmarks, height: textHeight, proxy: proxy)
                            }
                        }
                    }
                }
                .onPreferenceChange(HeightPreference.self) {
                    textHeight = $0
                }
                .compositingGroup()

            if showText {
                BarcodeLabel(barcode.checksumDigit)
                    .alignmentGuide(.bottom, computeValue: { dimension in
                        dimension[.bottom] - (textHeight / 2)
                    })
            }
        }
        .accessibility(addTraits: accessibilityTraits)
        .accessibility(value: Text(verbatim: barcode.value))
        .accessibility(label: Text(barcode.accessibilityLabel))
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
