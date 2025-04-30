//
//  CoreDataRepository.swift
//  Diyet4oo
//
//  Created by hamid on 1.05.2025.
//
import CoreData

protocol CoreDataRepositoryProtocol {
    associatedtype Entity: NSManagedObject
    func fetchAll() -> [Entity]
    func create() -> Entity
    func delete(_ entity: Entity)
    func save()
}

class CoreDataRepository<T: NSManagedObject>: CoreDataRepositoryProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataManager.shared.viewContext) {
        self.context = context
    }
    
    func fetchAll() -> [T] {
        let request = T.fetchRequest() as! NSFetchRequest<T>
        do {
            return try context.fetch(request)
        } catch {
           
            return []
        }
    }
    
    func create() -> T {
        T(context: context)
    }
    
    func delete(_ entity: T) {
        context.delete(entity)
    }
    
    func save() {
        CoreDataManager.shared.saveContext(context)
    }
}
