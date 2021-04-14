//
//  SwiftUIView.swift
//  
//
//  Created by Nate Rivard on 14/04/2021.
//

import SwiftUI

struct HeightPreference: PreferenceKey {
    static let defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
