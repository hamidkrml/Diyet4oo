//
//  SwiftUIView.swift
//  Diyet4oo
//
//  Created by hamid karimli on 9.05.2025.
//

import SwiftUI
struct PrimaryButton: View {
    var title: String
    var icon: String = "dot.circle.and.hand.point.up.left.fill"
    var color: Color = Color("ButtonC")
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text(title)
                    .foregroundColor(color)
                    .fontWeight(.semibold)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
            )
            .padding(.horizontal)
        }
    }
}
