//
//  CoreDataManeger.swift
//  Diyet4oo
//
//  Created by hamid on 30.04.2025.
//

import CoreData


class CoreDataManager {
    // Singleton pattern ile tek bir instance kullan
    static let shared = CoreDataManager()
    private init() {}
    
    // MARK: - Persistent Container
    // Veritabanı ve model yapılandırması
    lazy var persistentContainer: NSPersistentContainer = {
        let modelName = "diyet4oo"
        let container = NSPersistentContainer(name: modelName)
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Persistent store yüklenemedi: \(error)")
            }
        }
        
        // Ana context otomatik olarak değişiklikleri birleştirsin
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    // MARK: - Context'ler
    // UI işlemleri için ana context
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Arka plan işlemleri için yeni context
    func backgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    // MARK: - Save İşlemi
    // Değişiklikleri kaydet (Context parametresi ile esnek kullanım)
    func saveContext(_ context: NSManagedObjectContext) {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            print("Kaydetme hatası: \(error.localizedDescription)")
        }
    }
}
