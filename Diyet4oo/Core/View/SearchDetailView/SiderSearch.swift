//
//  ProductSider.swift
//  Diyet4oo
//
//  Created by hamid karimli on 8.05.2025.
//

import SwiftUI

struct SiderSearch: View {
    @State private var current = 10.0
    @State private var minValue = 0.0
    @State private var maxValue = 100.0
    var body: some View {
        VStack{
            Text("Kalori Takibi")

            Gauge(value: current, in: minValue...maxValue) {
                
                    
            } currentValueLabel: {
                Text("\(Int(current))")
            } minimumValueLabel: {
                Text("\(Int(minValue))")
            } maximumValueLabel: {
                Text("\(Int(current))")
            }
            .gaugeStyle(CustomGaugeStyle(maxValue: current, textgir: "\nKarbonHidrat"))
            
        }
    }
}

#Preview {
    SiderSearch()
}
