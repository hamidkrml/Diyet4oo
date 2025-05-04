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
 
    // sonu kalori
    
    
    
    
    private var cancellables = Set<AnyCancellable>()
    private var repository = CoreDataRepository<UserProfile>() // Generic Repo
    
    init(repository: CoreDataRepository<UserProfile> = .init(),
         coreDataStack: CoreDataManager = .shared) {
        self.repository = repository
        
        setupAutoSave()
    }
    // MARK: - genel o veri tabanlarin belirli bir zamandan sonra dinlenip core data kayit eden sure
    private func setupAutoSave() {
        // 8 yayını birleştirmek için iç içe CombineLatest kullanımı
        Publishers.CombineLatest(
            Publishers.CombineLatest4(
                $selectedGender,
                $selectedYear,
                $selectedHeight,
                $selectedWeight
            ),
            Publishers.CombineLatest4(
                $selectedDay,
                $selectedMonth,
                $hedefKilon,
                $hdefHaftan
            )
        )
        .debounce(for: .seconds(6.0), scheduler: RunLoop.main)
        .sink { [weak self] _ in
            // hedefKalori fonksiyonu hemen çağrılır
            self?.hedefKalori()
            
            // verileriKaydet fonksiyonu 2 saniye gecikmeli çağrılır
            DispatchQueue.main.asyncAfter(deadline: .now() + 40.0) {
                self?.verileriKaydet()
            }
        }
        .store(in: &cancellables)
    }
    
    
    
    // MARK: - "CoreData" - Kullancidan alinan bilgilerin veritabanina kayyit olmasi
    
    // kullancinin ozel bilgileri boy ceki hedefkilo falan hepsi burdan kayit oluyor coredataya
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
    
    
    // kullancinin gunluk tuketmesi gerek degerin core data Kayit
    func hedefKalori(){
        let context = CoreDataManager.shared.backgroundContext()
        let repository = CoreDataRepository<DailyIntake>(context: context)
        
        context.perform {
            let existingProfiles = repository.fetchAll()
            let dailyIntake: DailyIntake
            
            if let existing = existingProfiles.first {
                dailyIntake = existing
            } else {
                dailyIntake = repository.create()
            }
            
            dailyIntake.dailyCalories = Int32(self.gunlukKaloriIhtiyaci())
            repository.save()
        }
    }
    
    
    // MARK: - kullancinin tuketmesi gereken kcal hesaplayan fonksiyonu
    func gunlukKaloriIhtiyaci() -> Int {
        // 1. Doğum tarihi oluşturma (guard ile güvenli unwrap)
        guard let monthIndex = DateFormatter().monthSymbols.firstIndex(of: selectedMonth),
              let birthDate = Calendar.current.date(from: DateComponents(
                year: selectedYear,
                month: monthIndex + 1,
                day: selectedDay))
        else {
            return selectedGender == "Erkek" ? 1500 : 1200 // varsayılan minimum
        }
        
        // 2. Yaş hesaplama
        let age = Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
        
        // 3. BMR Hesabı
        let weight = Double(selectedWeight)
        let height = Double(selectedHeight)
        let gender = selectedGender
        let bmr: Double
        
        if gender == "Erkek" {
            bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * Double(age))
        } else {
            bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * Double(age))
        }
        
        // 4. Kalori açığı hesaplama (hafta sayısı sıfır olmasın!)
        guard hdefHaftan > 0 else {
            return Int(bmr * 1.2) // doğrudan aktivite faktörü uygulanmış hali döndür
        }
        
        let hedefKaybi = Double(selectedWeight - hedefKilon)
        let haftalikAcik = (hedefKaybi * 7700) / Double(hdefHaftan)
        let gunlukAcik = haftalikAcik / 7
        
        // 5. Aktivite Faktörü
        let aktiviteFaktoru = 1.2
        let netKalori = (bmr * aktiviteFaktoru) - gunlukAcik
        
        // 6. Minimum güvenli sınır kontrolü
        let minimumKalori = gender == "Erkek" ? 1500.0 : 1200.0
        return Int(max(netKalori, minimumKalori))
    }
    
    
    
    
    
}
