//
//  Boy .swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI
struct BoyKiloInputView: View {
   
    let heights = Array(150...220)
    let height = Array(40...120)
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var ViewModel: InputViewModel

    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                // button boyutlandirmak icin
                VStack(alignment: .center) {
                    ProgressBarView(currentStep: 3, totalSteps: 4)
                    // picker boyutlandirmak icin
                    VStack(spacing: geometry.size.width * 0.09) {
                        TextPickerComppent(baslik: "Boyunuz: ", deger: $ViewModel.selectedHeight, secenekler: heights)
                        TextPickerComppent(baslik: "Cekiniz: ", deger: $ViewModel.selectedWeight, secenekler: height)
                    }
                    .pickerStyle(.wheel)
                    .frame(width: geometry.size.width * 0.6,height: geometry.size.height * 0.6)
                    .padding(.top,geometry.size.width * 0.5)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 4)
                    
                    Spacer()
                    NavigationButton(destination: HedefInputView()   .environmentObject(ViewModel))
                        .padding(.bottom)
                }
                .toolbar { BackToolbarItem(dismiss: dismiss) }
                
            }
        }
    }
}
#Preview {
    BoyKiloInputView()
}
