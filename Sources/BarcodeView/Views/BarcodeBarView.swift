//
//  BarcodeBarView.swift
//  
//
//  Created by Nate Rivard on 10/17/19.
//

import SwiftUI

struct BarcodeBarView: View {

    private let digits: [BarcodeDigit]
    @Environment(\.barWidth) var barWidth: CGFloat

    init(digits: [BarcodeDigit]) {
        self.digits = digits
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<digits.count) { index in
                (try? self.digits[index].representation()).map { representation in
                    BarcodeDigitView(bars: representation)
                        .frame(width: CGFloat(representation.count) * self.barWidth)
                        .anchorPreference(key: BarcodeLandmarkPreference.self, value: .bounds) {
                            switch digits[index] {
                                case .endcap where index == 0:
                                    return .init(start: $0)
                                case .endcap:
                                    return .init(end: $0)
                                case .middle:
                                    return .init(middle: $0)
                                default:
                                    return .init()
                            }
                        }
                        .landmarkAlignmentGuide(digits[index], index: index)
                }
            }
        }
    }
}

extension View {

    @ViewBuilder
    func landmarkAlignmentGuide(_ digit: BarcodeDigit, index: Int) -> some View {
        switch digit {
            case .endcap where index == 0:
                self.alignmentGuide(.startLandmark, computeValue: { dimension in
                    dimension[.leading]
                })
            case .endcap:
                self.alignmentGuide(.endLandmark, computeValue: { dimension in
                    dimension[.trailing]
                })
            default:
                self
        }
    }
}
