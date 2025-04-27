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
        NavigationView {
            GeometryReader { geometry in
                
                VStack {
                    ProgressBarView(currentStep: 1, totalSteps: 4)
                    
                    
                    Spacer()
                    TextPickerComppent(baslik: "Cinsiyetiniz: ", deger: $ViewModel.selectedGender, secenekler: cinsiyetler)
                        .pickerStyle(.wheel)
                    
                    Spacer()
                    NavigationButton(destination: DogumYiliInputView()
                        .environmentObject(ViewModel))
                    
                }
                .toolbar { BackToolbarItem(dismiss: dismiss) }
            }
        }
        
    }
}

#Preview {
    CinsiyetInputView()
}
