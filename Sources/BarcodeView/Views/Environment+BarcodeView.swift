//
//  Environment+BarcodeView.swift
//  
//
//  Created by Nate Rivard on 05/12/2019.
//

import SwiftUI

enum BarWidthEnvironmentKey: EnvironmentKey {
    static var defaultValue: CGFloat = 2
}

extension EnvironmentValues {

    public var barWidth: CGFloat {
        get { self[BarWidthEnvironmentKey.self] }
        set { self[BarWidthEnvironmentKey.self] = newValue }
    }
}
