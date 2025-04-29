//
//  CompleteView.swift
//  Diyet4oo
//
//  Created by hamid on 26.04.2025.
//

import SwiftUI

struct CompleteView: View {
    @EnvironmentObject var ViewModel: InputViewModel
    
    var body: some View {
        let gunlukKalori = ViewModel.gunlukKaloriIhtiyaci()
        NavigationView {
            VStack(spacing: 30) {
                Text(ViewModel.selectedGender)
                Text(ViewModel.selectedMonth)
                Text(String(ViewModel.selectedDay))
                Text(String(ViewModel.selectedYear))
                Text(String(ViewModel.selectedHeight))
                Text(String(ViewModel.selectedWeight))
                Text(String(gunlukKalori))
                
                NavigationButton(destination: MainTabView())
            }
        }
       

    }
}
