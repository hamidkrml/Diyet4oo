//
//  GaugeStyle.swift
//  Diyet4oo
//
//  Created by hamid on 29.04.2025.
//

import SwiftUI


struct CustomGaugeStyle: GaugeStyle {
    var maxValue: Double
    var textgir : String
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            
            
            ZStack {
                // Arka plan dairesi (tam gri çember)
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(configuration.value))
                    .stroke(Color.blue, lineWidth: 8)
                    .rotationEffect(.degrees(-90))
                VStack(spacing: 2){
                    Text("\(Int(max(0, maxValue - (configuration.value * maxValue))))  ")                    .font(.title2)
                        .bold()
                        .foregroundColor(.black.opacity(0.7))
                    
                    Text(textgir)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray.opacity(0.6))
                        
                }
                
            }
            
            .frame(width: 100, height: 100)
            
            
        }
    }
}

