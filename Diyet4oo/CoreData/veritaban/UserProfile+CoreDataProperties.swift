//
//  UserProfile+CoreDataProperties.swift
//  Diyet4oo
//
//  Created by hamid on 1.05.2025.
//
//

import Foundation
import CoreData


extension UserProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserProfile> {
        return NSFetchRequest<UserProfile>(entityName: "UserProfile")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var gender: String?
    @NSManaged public var birthDay: Int32
    @NSManaged public var birthMonth: String?
    @NSManaged public var birthYear: Int32
    @NSManaged public var height: Int32
    @NSManaged public var weight: Int32
    @NSManaged public var targetWeight: Int32
    @NSManaged public var targetWeeks: Int32
    @NSManaged public var createdAt: Date?
    
}

extension UserProfile : Identifiable {

}
















extension DailyIntake {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyIntake> {
        return NSFetchRequest<DailyIntake>(entityName: "DailyIntake")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date : Date?
    @NSManaged public var caloriesTaken: Int32
    @NSManaged public var dailyCalories:Int32
    
}

extension DailyIntake : Identifiable {

}




extension Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food")
    }

   
    @NSManaged public var name: String?          // Malzeme Adı
    @NSManaged public var portion: Double        // Porsiyon (g)
    @NSManaged public var energy: Int16          // Enerji (kcal)
    @NSManaged public var fat: Double            // Yağ (g)
    @NSManaged public var carb: Double           // Karbonhidrat (g)
    @NSManaged public var protein: Double        // Protein (g)
    @NSManaged public var sugar: Double          // Şeker (g)
    @NSManaged public var fiber: Double          // Fiber (g)
    
}

extension Food : Identifiable {

}
