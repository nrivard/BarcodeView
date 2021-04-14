//
//  ContentView.swift
//  UPCTestApp
//
//  Created by Nate Rivard on 10/18/19.
//  Copyright © 2019 Nate Rivard. All rights reserved.
//

import BarcodeView
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ScrollView {
            Spacer()
                .frame(height: 36)
            
            VStack(spacing: 36) {
                BarcodeView(BarcodeFactory.barcode(from: "302993918288")!)
                    .frame(height: 60)
                    .environment(\.barWidth, 1)

                BarcodeView(BarcodeFactory.barcode(from: "302993918288")!, showText: false)
                    .frame(height: 60)
                    .environment(\.barWidth, 1)

                BarcodeView(BarcodeFactory.barcode(from: "5099902988016")!)
                    .frame(height: 120)

                BarcodeView(BarcodeFactory.barcode(from: "5099902988016")!, showText: false)
                    .frame(height: 120)

                BarcodeView(BarcodeFactory.barcode(from: "5099902988016")!)
                    .frame(height: 120)
                    .foregroundColor(.purple)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
