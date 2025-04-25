//
//  Cinsiyet.swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI

struct Cinsiyet: View {
    let cinsiyetler = ["Erkek", "Kadın", "Belirtmek İstemiyorum"]
    @State private var selectedGender = "Belirtmek İstemiyorum"
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                
                VStack {
                    VStack {
                        TextPickerComppent(baslik: "Cinsiyetiniz: ", deger: $selectedGender, secenekler: cinsiyetler)
                            .pickerStyle(.wheel)
                    }
                    .frame(width: geometry.size.width * 0.6,height: geometry.size.height * 0.6)
                    .padding(.top,geometry.size.width * 0.5)
                    .position(x: geometry.size.width / 2 , y: geometry.size.height / 3)
                    
                    NavigationLink {
                        Dogumyil()
                            .navigationBarBackButtonHidden()

                    } label: {
                        ButtonCompenet(tiitle: "Devam")
                    }
                    .padding(.bottom)
                }
                
                
            }
        }
        
    }
}

#Preview {
    Cinsiyet()
}
