//
//  InputViewModel.swift
//  Diyet4oo
//
//  Created by hamid on 26.04.2025.
//

import Foundation
import Combine
import CoreData

class InputViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var selectedGender = "Belirtmek İstemiyorum"
    @Published var selectedDay = 5
    @Published var selectedMonth = DateFormatter().monthSymbols[7]
    @Published var selectedYear = 2000
    @Published var selectedHeight = 170
    @Published var selectedWeight = 70
    @Published var targetWeight: Int = 50
    @Published var targetWeeks: Int = 4
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    private var repository = CoreDataRepository<UserProfile>()
    
    // MARK: - Initialization
    init(repository: CoreDataRepository<UserProfile> = .init(),
         coreDataStack: CoreDataManager = .shared) {
        self.repository = repository
    }
    
    
    
    // MARK: - Data Management
    
    /// Saves user profile data to CoreData
    func saveUserData() {
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
            userProfile.targetWeight = Int32(self.targetWeight)
            userProfile.targetWeeks = Int32(self.targetWeeks)
            
            
            do {
                try repository.save()
            } catch {
                print("Error saving user data: \(error)")
            }
            
        }
    }
    
    
    /// Saves daily calorie target to CoreData
    func saveDailyCalorieTarget() {
        let context = CoreDataManager.shared.viewContext // Artık ana context kullanılıyor
        let repository = CoreDataRepository<DailyIntake>(context: context)
        context.perform {
            let existingProfiles = repository.fetchAll()
            let dailyIntake: DailyIntake
            if let existing = existingProfiles.first {
                dailyIntake = existing
            } else {
                dailyIntake = repository.create()
            }
            dailyIntake.dailyCalories = Int32(self.calculateDailyCalorieNeeds())
            print("Daily calorie target calculated:", dailyIntake.dailyCalories)
            do {
                try repository.save()
                print("Daily calorie target saved:", dailyIntake.dailyCalories)
            } catch {
                print("Error saving daily calorie target: \(error)")
            }
        }
    }
    
    
    // MARK: - Calorie Calculation
    
    /// Calculates daily calorie needs based on user profile
    func calculateDailyCalorieNeeds() -> Int {
        // 1. Create birth date with safe unwrapping
        guard let monthIndex = DateFormatter().monthSymbols.firstIndex(of: selectedMonth),
              let birthDate = Calendar.current.date(from: DateComponents(
                year: selectedYear,
                month: monthIndex + 1,
                day: selectedDay))
        else {
            return selectedGender == "Erkek" ? 1500 : 1200 // default minimum
        }
        
        // 2. Calculate age
        let age = Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
        
        // 3. Calculate BMR (Basal Metabolic Rate)
        let weight = Double(selectedWeight)
        let height = Double(selectedHeight)
        let gender = selectedGender
        let bmr: Double
        
        if gender == "Erkek" {
            bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * Double(age))
        } else {
            bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * Double(age))
        }
        
        // 4. Calculate calorie deficit (ensure weeks is not zero)
        guard targetWeeks > 0 else {
            return Int(bmr * 1.2) // return BMR with activity factor applied
        }
        
        let targetWeightLoss = Double(selectedWeight - targetWeight)
        let weeklyDeficit = (targetWeightLoss * 7700) / Double(targetWeeks)
        let dailyDeficit = weeklyDeficit / 7
        
        // 5. Apply activity factor
        let activityFactor = 1.2
        let netCalories = (bmr * activityFactor) - dailyDeficit
        
        // 6. Ensure minimum safe calorie limit
        let minimumCalories = gender == "Erkek" ? 1500.0 : 1200.0
        return Int(max(netCalories, minimumCalories))
    }
    
    
    
    
}
