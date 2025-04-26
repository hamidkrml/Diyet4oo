//
//  InputViewModel.swift
//  Diyet4oo
//
//  Created by hamid on 26.04.2025.
//

import Foundation
import Combine

class InputViewModel : ObservableObject {
       @Published var selectedGender = "Belirtmek İstemiyorum"
       @Published var selectedDay = 5
       @Published var selectedMonth =  DateFormatter().monthSymbols[7]
       @Published var selectedYear = 2000
       @Published var selectedHeight = 170
       @Published var selectedWeight = 70
    
       @Published var hedefKilon: Int = 50
       @Published var hdefHaftan: Int = 4
       
       
        
    
    func gunlukKaloriIhtiyaci() -> Int {
           // 1. Yaş Hesaplama
           let calendar = Calendar.current
           let currentDate = Date()
           let birthDate = calendar.date(from: DateComponents(
               year: selectedYear,
               month: DateFormatter().monthSymbols.firstIndex(of: selectedMonth)! + 1,
               day: selectedDay
           ))!
           
           let ageComponents = calendar.dateComponents([.year], from: birthDate, to: currentDate)
           let age = ageComponents.year!
           
           // 2. Bazal Metabolizma Hızı (BMR)
           let bmr: Double
           if selectedGender == "Erkek" {
               bmr = 88.362 + (13.397 * Double(selectedWeight)) + (4.799 * Double(selectedHeight)) - (5.677 * Double(age))
           } else { // Kadın veya diğer
               bmr = 447.593 + (9.247 * Double(selectedWeight)) + (3.098 * Double(selectedHeight)) - (4.330 * Double(age))
           }
           
           // 3. Kalori Açığı Hesaplama
           let kiloKaybi = Double(selectedWeight - hedefKilon)
           let haftalikKaloriAcigi = (kiloKaybi * 7700) / Double(hdefHaftan)
           let gunlukKaloriAcigi = haftalikKaloriAcigi / 7
           
           // 4. Aktivite Faktörü (Hareketsiz varsayım)
           let aktiviteFaktoru = 1.2
           
           // 5. Net Kalori İhtiyacı
           let netKalori = (bmr * aktiviteFaktoru) - gunlukKaloriAcigi
           
           // 6. Güvenli Alt Sınır Kontrolü
           let minimumKalori = selectedGender == "Erkek" ? 1500.0 : 1200.0
           return Int(max(netKalori, minimumKalori))
       }
   }
