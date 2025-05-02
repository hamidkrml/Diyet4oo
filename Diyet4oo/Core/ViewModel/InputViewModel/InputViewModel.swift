//
//  InputViewModel.swift
//  Diyet4oo
//
//  Created by hamid on 26.04.2025.
//

import Foundation
import Combine
import CoreData
class InputViewModel : ObservableObject {
       @Published var selectedGender = "Belirtmek İstemiyorum"
       @Published var selectedDay    = 5
       @Published var selectedMonth  =  DateFormatter().monthSymbols[7]
       @Published var selectedYear   = 2000
       @Published var selectedHeight = 170
       @Published var selectedWeight = 70
    
       @Published var hedefKilon: Int = 50
       @Published var hdefHaftan: Int = 4
    
    @Published var kayitDurumuMesaji: String?
    @Published var showAlert = false
    
    
    private var cancellables = Set<AnyCancellable>()
    private var repository = CoreDataRepository<UserProfile>() // Generic Repo

//    init(repository: CoreDataRepository<UserProfile> = .init(),
//             coreDataStack: CoreDataManager = .shared) {
//            self.repository = repository
//
//            setupAutoSave()
//        }
//
//    private func setupAutoSave() {
//        // 8 yayını birleştirmek için iç içe CombineLatest kullanımı
//        Publishers.CombineLatest(
//            Publishers.CombineLatest4(
//                $selectedGender,
//                $selectedYear,
//                $selectedHeight,
//                $selectedWeight
//            ),
//            Publishers.CombineLatest4(
//                $selectedDay,
//                $selectedMonth,
//                $hedefKilon,
//                $hdefHaftan
//            )
//        )
//        .debounce(for: .seconds(1.5), scheduler: RunLoop.main)
//        .sink { [weak self] _ in
//            self?.verileriKaydet()
//        }
//        .store(in: &cancellables)
//    }
    
    func verileriKaydet() {
        let context = CoreDataManager.shared.backgroundContext()
        let repository = CoreDataRepository<UserProfile>(context: context)

        context.perform {
            let existingProfiles = repository.fetchAll()
            let userProfile: UserProfile

            if let existing = existingProfiles.first {
                userProfile = existing
            } else {
                userProfile = repository.create()
            }

            userProfile.gender = self.selectedGender
            userProfile.birthYear = Int32(self.selectedYear)
            userProfile.height = Int32(self.selectedHeight)
            userProfile.weight = Int32(self.selectedWeight)
            userProfile.birthDay = Int32(self.selectedDay)
            userProfile.birthMonth = self.selectedMonth
            userProfile.targetWeight = Int32(self.hedefKilon)
            userProfile.targetWeeks = Int32(self.hdefHaftan)

            repository.save()
        }
    }
     
    
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
