//
//  Cinsiyet.swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI

struct CinsiyetInputView: View {
    let cinsiyetler = ["Erkek", "Kadın", "Belirtmek İstemiyorum"]
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var ViewModel: InputViewModel
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                
                VStack {
                    ProgressBarView(currentStep: 1, totalSteps: 4)
                      
                    VStack {
                        
                        TextPickerComppent(baslik: "Cinsiyetiniz: ", deger: $ViewModel.selectedGender, secenekler: cinsiyetler)
                            .pickerStyle(.wheel)
                    }
                    .frame(width: geometry.size.width * 0.6,height: geometry.size.height * 0.6)
                    .padding(.top,geometry.size.width * 0.5)
                    .position(x: geometry.size.width / 2 , y: geometry.size.height / 3)
                    
                    NavigationButton(destination: DogumYiliInputView()
                        .environmentObject(ViewModel))
                        
                    .padding(.bottom)
                }
                .toolbar { BackToolbarItem(dismiss: dismiss) }
            }
        }
        
    }
}

#Preview {
    CinsiyetInputView()
}
