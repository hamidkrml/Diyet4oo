//
//  ButtonCompenet.swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI

struct ButtonCompenet: View {
    var tiitle : String
    var body: some View {
        Text(tiitle)
            .font(.subheadline)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity,minHeight: 30)
        
            .foregroundStyle(Color("ButtonC"))
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.gray,lineWidth: 2)
            )
            .padding(.horizontal)
    }
}
