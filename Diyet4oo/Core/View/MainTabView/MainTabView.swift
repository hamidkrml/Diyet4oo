//
//  MainTabView.swift
//  Diyet4oo
//
//  Created by hamid on 26.04.2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            GunlukView()
                
                .tabItem {
                    Label("Günlük", systemImage: "book.pages")
                }
            
//            ProfilView()
//                .tabItem {
//                    Label("Profil", systemImage: "person.fill")
//                }
            
        }
    }
}

#Preview {
    MainTabView()
}
