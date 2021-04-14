//
//  BarcodeCutout.swift
//  
//
//  Created by Nate Rivard on 14/04/2021.
//

import SwiftUI

struct BarcodeCutout: View {
    private let landmarks: BarcodeLandmarkPreference.Landmarks
    private let height: CGFloat
    private let proxy: GeometryProxy

    init(landmarks: BarcodeLandmarkPreference.Landmarks, height: CGFloat, proxy: GeometryProxy) {
        self.landmarks = landmarks
        self.height = height
        self.proxy = proxy
    }

    var body: some View {
        let centerLeadingGroupFrame = landmarks.centerLeadingGroupFrame(in: proxy, textHeight: height)
        let centerTrailingGroupFrame = landmarks.centerTrailingGroupFrame(in: proxy, textHeight: height)

        ZStack {
            Rectangle()
                .offset(x: centerLeadingGroupFrame.origin.x, y: centerLeadingGroupFrame.origin.y)
                .frame(width: centerLeadingGroupFrame.size.width, height: centerLeadingGroupFrame.size.height)

            Rectangle()
                .offset(x: centerTrailingGroupFrame.origin.x, y: centerTrailingGroupFrame.origin.y)
                .frame(width: centerTrailingGroupFrame.size.width, height: centerTrailingGroupFrame.size.height)
        }
        .blendMode(.destinationOut)
    }
}
