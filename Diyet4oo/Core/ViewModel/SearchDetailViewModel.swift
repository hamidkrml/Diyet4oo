//
//  SearchDetailViewModel.swift
//  Diyet4oo
//
//  Created by hamid karimli on 27.07.25.
//

import Foundation
import CoreData

class SearchDetailViewModel: ObservableObject {
    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func addFoodToTodayIntake(food: Food) {
        let today = Calendar.current.startOfDay(for: Date())
        let fetchRequest: NSFetchRequest<DailyIntake> = DailyIntake.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", today as NSDate)

        do {
            let results = try context.fetch(fetchRequest)
            let dailyIntake: DailyIntake
            if let existing = results.first {
                dailyIntake = existing
            } else {
                dailyIntake = DailyIntake(context: context)
                dailyIntake.date = today
                // İstersen burada günlük hedef değerleri de ayarlayabilirsin
            }

            dailyIntake.caloriesTaken += Int32(food.energy)
            dailyIntake.proteinTaken += food.protein
            dailyIntake.fatTaken += food.fat
            dailyIntake.carbTaken += food.carb

            try context.save()
        } catch {
            print("Günlük intake güncellenemedi: \(error)")
        }
    }
}
