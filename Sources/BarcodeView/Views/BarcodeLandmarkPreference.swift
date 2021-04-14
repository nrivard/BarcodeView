//
//  SwiftUIView.swift
//  
//
//  Created by Nate Rivard on 12/04/2021.
//

import SwiftUI

struct BarcodeLandmarkPreference: PreferenceKey {
    struct Landmarks {
        var start: Anchor<CGRect>?
        var middle: Anchor<CGRect>?
        var end: Anchor<CGRect>?
    }

    static let defaultValue: Landmarks = .init()

    static func reduce(value: inout Landmarks, nextValue: () -> Landmarks) {
        let next = nextValue()
        var composite = value

        if let start = next.start {
            composite.start = start
        }

        if let middle = next.middle {
            composite.middle = middle
        }

        if let end = next.end {
            composite.end = end
        }

        value = composite
    }
}

extension BarcodeLandmarkPreference.Landmarks {

    func centerLeadingGroupFrame(in proxy: GeometryProxy, textHeight: CGFloat) -> CGRect {
        guard let start = start, let middle = middle else { return .zero }

        return .init(
            x: proxy[start].maxX,
            y: proxy[start].maxY - (textHeight / 2),
            width: proxy[middle].minX - proxy[start].maxX + 1, // this is 1 pixel too small from the landmarks so add 1
            height: textHeight
        )
    }

    func centerTrailingGroupFrame(in proxy: GeometryProxy, textHeight: CGFloat) -> CGRect {
        guard let end = end, let middle = middle else { return .zero }

        return .init(
            x: proxy[middle].maxX - 1,  // this is 1 pixel too far to the right so subtract 1
            y: proxy[end].maxY - (textHeight / 2),
            width: proxy[end].minX - proxy[middle].maxX,
            height: textHeight
        )
    }
}
