//
//  Boy .swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI
struct BoyKiloInputView: View {
    @State private var selectedHeight = 170
    @State private var selectedHeight1 = 170
    let heights = Array(150...220)
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                // button boyutlandirmak icin
                VStack(alignment: .center) {
                    
                    // picker boyutlandirmak icin
                    VStack(spacing: geometry.size.width * 0.09) {
                        TextPickerComppent(baslik: "Boyunuz: ", deger: $selectedHeight, secenekler: heights)
                        TextPickerComppent(baslik: "Cekiniz: ", deger: $selectedHeight1, secenekler: heights)
                    }
                    .pickerStyle(.wheel)
                    .frame(width: geometry.size.width * 0.6,height: geometry.size.height * 0.6)
                    .padding(.top,geometry.size.width * 0.5)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 4)
                    
                    Spacer()
                    NavigationButton(destination: CinsiyetInputView())
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
