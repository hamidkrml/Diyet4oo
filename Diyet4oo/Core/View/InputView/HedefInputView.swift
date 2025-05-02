//
//  HedefInputView.swift
//  Diyet4oo
//
//  Created by hamid on 26.04.2025.
//

import SwiftUI

struct HedefInputView: View {
    
     let hedefKilon = Array(40...120)
     let HedefHaftan = Array(1...30)
     @Environment(\.dismiss) var dismiss
     @EnvironmentObject var ViewModel: InputViewModel

     
     var body: some View {
         NavigationStack {
             GeometryReader { geometry in
                 // button boyutlandirmak icin
                 VStack(alignment: .center) {
                     ProgressBarView(currentStep: 4, totalSteps: 4)
                     // picker boyutlandirmak icin
                     VStack(spacing: geometry.size.width * 0.09) {
                         TextPickerComppent(baslik: "Hedef Kilon: ", deger: $ViewModel.hedefKilon, secenekler: hedefKilon)
                         TextPickerComppent(baslik: "Hedef Haftan: ", deger: $ViewModel.hdefHaftan, secenekler: HedefHaftan)
                        
                         
                     }
                     .pickerStyle(.wheel)
                     .frame(width: geometry.size.width * 0.6,height: geometry.size.height * 0.6)
                     .padding(.top,geometry.size.width * 0.5)
                     .position(x: geometry.size.width / 2, y: geometry.size.height / 4)
                     
                     Spacer()
                     NavigationButton(destination: CompleteView()   .environmentObject(ViewModel))
                     
                     //yeni button eklenecek veri tabanina kayit icin 
//                     DispatchQueue.global(qos: .userInitiated).async {
//                         ViewModel.verileriKaydet()
//                     }
                         .padding(.bottom)
                 }
                 .toolbar { BackToolbarItem(dismiss: dismiss) }
                 
             }
         }
        
     }
}

#Preview {
    HedefInputView()
}
