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
