//
//  NavigationLinkButton.swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI

 struct NavigationButton: View {
    let destination: any View
   
    var body: some View {
        NavigationLink {
            AnyView(destination)
                .navigationBarBackButtonHidden()
                
        } label: {
            ButtonComponent(title: "hamit")
        }
        .padding(.bottom)
    }
}
