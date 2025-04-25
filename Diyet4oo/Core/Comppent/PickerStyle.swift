//
//  SwiftUIView.swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI
struct CustomPicker<T: Hashable & CustomStringConvertible>: View {
    let title: String
    @Binding var selection: T
    let options: [T]
    let validation: ((T) -> Bool)?
    let errorMessage: String?
    
    // İsteğe bağlı stil ve özelleştirmeler
   
    var labelColor: Color = .primary
    var errorColor: Color = .red
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Başlık
            Text(title)
                .font(.headline)
                .foregroundColor(labelColor)
            
            // Picker
            Picker(title, selection: $selection) {
                ForEach(options, id: \.self) { option in
                    Text(option.description)
                        .tag(option)
                }
            }
            .pickerStyle(.inline)
            
            // Hata Mesajı
            if let validation = validation, !validation(selection), let message = errorMessage {
                Text(message)
                    .font(.caption)
                    .foregroundColor(errorColor)
            }
        }
    }
}
