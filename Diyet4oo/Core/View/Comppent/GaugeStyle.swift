//
//  GaugeStyle.swift
//  Diyet4oo
//
//  Created by hamid on 29.04.2025.
//

import SwiftUI


struct CustomGaugeStyle: GaugeStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            
            
            ZStack {
                Circle()
                    .trim(from: 0.0, to: CGFloat(configuration.value))
                    .stroke(Color.blue, lineWidth: 8)
                    .rotationEffect(.degrees(-90))
                
                Text("\(Int(configuration.value * 100)) ")
                    .font(.title2)
                    .bold()
                +
                Text("Kalan")
                    .font(.footnote)
            }
            .frame(width: 100, height: 100)
            
            
        }
    }
}

