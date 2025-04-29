//
//  ProfilView.swift
//  Diyet4oo
//
//  Created by hamid on 26.04.2025.
//

import SwiftUI
struct ProfilView:View {
    var body: some View {
       
        NavigationView {
            ScrollView {
                VStack{
                    Spacer()
                    Divider()
                    productSider()
                    Divider()
                    productCard(image: "icon", title: "Kahvalti")
                    Divider()
                    productCard(image: "icon", title: "Öğle Yemeği")
                    Divider()
                    
                    productCard(image: "icon", title: "Akşam Yemeği")
                    Divider()
                    productCard(image: "icon", title: "Ara Ögün")
                    Divider()
                    
                }.padding(.horizontal)
            }.navigationTitle("Bugun")
            
        }
        
    }
}

#Preview{
    ProfilView()
}













