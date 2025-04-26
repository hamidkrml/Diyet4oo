//
//  sajida.swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI
// ProgressBarView.swift
struct ProgressBarView: View {
    let currentStep: Int
    let totalSteps: Int // ViewModel'den alınan değer

    var body: some View {
        VStack {
            HStack {
                ForEach(1...totalSteps, id: \.self) { step in
                    Circle()
                        .frame(width: 20)
                        .foregroundColor(step <= currentStep ? .yellow.opacity(0.7) : .gray)
                        
                    if step != totalSteps {
                        Rectangle()
                            .frame(width: 40, height: 2)
                            .foregroundColor(step < currentStep ? .yellow.opacity(0.7) : .gray)
                    }
                }
            }
            Text("Adım \(currentStep)/\(totalSteps)")
        }
    }
}
