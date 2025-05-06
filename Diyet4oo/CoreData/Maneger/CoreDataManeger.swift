//
//  CoreDataManeger.swift
//  Diyet4oo
//
//  Created by hamid on 30.04.2025.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    
    
    
    // MARK: - Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let modelName = "diyet4oo" // Data Model dosyanızın adı
        let container = NSPersistentContainer(name: modelName)
        
        
        let storeDescription = container.persistentStoreDescriptions.first
        
        // Lightweight Migration aktif et (Model değişikliklerinde otomatik geçiş)
        storeDescription?.setOption(true as NSNumber, forKey: NSMigratePersistentStoresAutomaticallyOption)
        storeDescription?.setOption(true as NSNumber, forKey: NSInferMappingModelAutomaticallyOption)
        
        container.loadPersistentStores { [weak self] _, error in
            if let error = error {
                
            }
            
            
        }
        // Main thread kısıtlaması (UI için güvenlik)



        

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        return container
    }()
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // Background Context
    func backgroundContext() -> NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
    
    // Save işlemi
    func saveContext(_ context: NSManagedObjectContext)->Result<Void, Error> {
        guard context.hasChanges else { return .success(()) }
        
        do {
            try context.save()
            return .success(())
        } catch {
            context.rollback()
            return .failure(error)
        }
    }
    
    
    func initializeData() {

        DispatchQueue.global(qos: .userInitiated).async { [self] in
            CSVImporter.importCSVInBackground(named: "Food", container: persistentContainer)
        }
        
    }
    

}

