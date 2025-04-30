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
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            print("Takvim butonuna tıklandı")
                        }) {
                            calendarIconView()
                        }
                    }
                }
        }
        
    }
}

#Preview{
    ProfilView()
}





///MARK:- Tabardaki button ozeligi
@ViewBuilder
func calendarIconView() -> some View {
    if #available(iOS 18.0, *) {
        Image(systemName: "calendar.and.person")
            .symbolEffect(.breathe.pulse.wholeSymbol, options: .repeat(.continuous))
            .foregroundStyle(Color("Text"))
    } else {
        Image(systemName: "calendar.and.person")
    }
    /// yeni tab button eklense buraya eklenecek 
}
