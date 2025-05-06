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
            ProfilView()
            
                .tabItem {
                    Label("Günlük", systemImage: "book.pages")
                }
            
            GunlukView()
                .tabItem {
                    Label("Profil", systemImage: "person.fill")
                }
            
        }
        
    }
}
