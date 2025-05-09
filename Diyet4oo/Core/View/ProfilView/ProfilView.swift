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
                VStack(spacing:20){
                    Spacer()
                    Divider()
                    productSider()
                    
                    Spacer()
                    NavigationLink {
                        SearchView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        productCard(image: "icon", title: "   Kahvalti")
                    }
                    Divider()
                    
                    NavigationLink {
                        SearchView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        productCard(image: "icon", title: "Öğle ")
                    }
                    
                    Divider()
                    
                    NavigationLink {
                        SearchView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        productCard(image: "icon", title: "Akşam ")
                    }
                    
                    
                    Divider()
                    NavigationLink {
                        SearchView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        productCard(image: "icon", title: "Ara Ögün")
                    }
                    
                    Divider()
                    
                }.padding(.horizontal)
            }.navigationTitle("Bugun")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            print("Takvim butonuna tıklandı")
                        }) {
                            // buraya animasyonlu
                            Image(systemName: "calendar.and.person")
                        }
                    }
                }
        }
        
    }
}

#Preview {
    ProfilView()
}

/////MARK:- Tabardaki button ozeligi
//@ViewBuilder
//func calendarIconView() -> some View {
//    if #available(iOS 18.0, *) {
//        Image(systemName: "calendar.and.person")
//            .symbolEffect(.breathe.pulse.wholeSymbol, options: .repeat(.continuous))
//            .foregroundStyle(Color("Text"))
//    } else {
//        Image(systemName: "calendar.and.person")
//    }
//    /// yeni tab button eklense buraya eklenecek
//}
