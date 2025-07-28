//
//  CardModifiler.swift
//  Diyet4oo
//
//  Created by hamid on 29.04.2025.
//

import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        
            .cornerRadius(10)
            .shadow(color:Color.green.opacity(0.65), radius: 10, x: 0, y: 5)
    }
}
