//
//  NavigationBack.swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI
struct BackToolbarItem: ToolbarContent {
   let dismiss: DismissAction
    
   var body: some ToolbarContent {
       ToolbarItem(placement: .topBarLeading) {
           Image(systemName: "chevron.left")
               .foregroundColor(.black)
               .imageScale(.large)
               .onTapGesture(perform: dismiss.callAsFunction)
       }
   }
}
