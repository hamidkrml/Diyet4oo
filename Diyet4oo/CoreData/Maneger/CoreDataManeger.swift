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
        let container = NSPersistentContainer(name: "diyet4oo")
        
        let storeDescription = container.persistentStoreDescriptions.first
        storeDescription?.setOption(true as NSNumber, forKey: NSMigratePersistentStoresAutomaticallyOption)
        storeDescription?.setOption(true as NSNumber, forKey: NSInferMappingModelAutomaticallyOption)
        
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data load error: \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Onboarding State Management
    func isOnboardingCompleted() -> Bool {
        let request: NSFetchRequest<OnboardingState> = OnboardingState.fetchRequest()
        request.fetchLimit = 1
        
        do {
            let state = try viewContext.fetch(request).first
            return state?.isCompleted ?? false
        } catch {
            print("Onboarding state fetch error: \(error)")
            return false
        }
    }
    
    func completeOnboarding() {
        if NSEntityDescription.entity(forEntityName: "OnboardingState", in: viewContext) == nil {
            print("❌ OnboardingState entity bulunamadı!")
        } else {
            print("✅ OnboardingState entity bulundu.")
        }
        let request: NSFetchRequest<OnboardingState> = OnboardingState.fetchRequest()
        request.fetchLimit = 1
        
        do {
            let state = try viewContext.fetch(request).first ?? OnboardingState(context: viewContext)
            state.isCompleted = true
            try saveContext(viewContext) // Burada saveContext kullanıyoruz
        } catch {
            print("Failed to save onboarding state: \(error)")
            viewContext.rollback()
        }
    }
    
    // MARK: - Background Context
    func backgroundContext() -> NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
    
    // MARK: - Save Context (Düzeltilmiş)
    func saveContext(_ context: NSManagedObjectContext) throws {
        guard context.hasChanges else { return }
        try context.save()
    }
    
    func saveContextWithResult(_ context: NSManagedObjectContext) -> Result<Void, Error> {
        guard context.hasChanges else { return .success(()) }
        
        do {
            try context.save()
            return .success(())
        } catch {
            context.rollback()
            return .failure(error)
        }
    }
    
    // MARK: - Data Initialization
    func initializeData() {
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            let context = backgroundContext()
            context.perform {
                if !self.isOnboardingCompleted() {
                    CSVImporter.importCSVInBackground(named: "Food", container: persistentContainer)
                }
            }
        }
    }
}
