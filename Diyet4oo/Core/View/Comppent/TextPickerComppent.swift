//
//  TextPickerComppent.swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI

struct TextPickerComppent<T: Hashable & CustomStringConvertible>: View {
    let baslik : String
    @Binding var deger: T
    let secenekler : [T]
    
    var body: some View {
        Text(baslik)
            .font(.subheadline)
            .fontWeight(.regular)
            .foregroundColor(Color("ButtonC"))
        
        +
        Text("\(deger)")
            .underline(true,color: .gray)
        
        Picker("Boyunuzu Giriniz", selection: $deger) {
            ForEach(secenekler, id: \.self) { hamit in
                Text("\(hamit)")
            }
        }
    }
}

