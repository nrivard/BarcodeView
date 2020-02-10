//
//  BarcodeBarView.swift
//  
//
//  Created by Nate Rivard on 10/17/19.
//

import SwiftUI

struct BarcodeBarView: View {

    private let digits: [BarcodeDigit]

    init(digits: [BarcodeDigit]) {
        self.digits = digits
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<digits.count) { index in
                (try? self.digits[index].representation()).map { representation in
                    BarcodeDigitView(bars: representation)
                }
            }
        }
    }
}
