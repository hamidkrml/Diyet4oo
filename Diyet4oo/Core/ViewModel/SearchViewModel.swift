//
//  SwiftUIView.swift
//  Diyet4oo
//
//  Created by hamid karimli on 6.05.2025.
//
import CoreData
import Combine

/// ViewModel sınıfı, Core Data'dan `Food` entity'sini çekip arama metnine göre filtreleme yapar.
class SearchViewModel:NSObject,ObservableObject{
    
    // MARK: - Published Properties
    
    /// Kullanıcının arama çubuğuna yazdığı metin.
    @Published var seachText:String = ""
    
    /// Arama sonucunda filtrelenmiş `Food` nesneleri.
    @Published var filtered:[Food] = []
    
    
    // MARK: - Private Properties
    
    /// Combine cancellable set: abonelikleri yaşam döngüsünde tutar.
    private var cancellables = Set<AnyCancellable>()
    /// Core Data sorgularını yönetmek için kullanılan FetchedResultsController.
    private var fetchedResultsController: NSFetchedResultsController<Food>
    
    // MARK: - Initialization
    
    /// ViewModel oluşturucusu, Managed Object Context alır.
    /// - Parameter context: Core Data context.
    
    init(context: NSManagedObjectContext) {
        // 1. Fetch Request hazırlanır: `Food` entity'sindeki tüm kayıtlar, ada göre sıralı.
        let fetchRequest: NSFetchRequest<Food> = Food.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // 2. NSFetchedResultsController setup
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        
        // Delegate olarak kendimizi atıyoruz, içerik değişikliklerini dinlemek için.
        fetchedResultsController.delegate = self
        
        // 3. İlk fetch işlemi: Tüm kayıtları `filtered` dizisine atıyoruz.
        do {
            try fetchedResultsController.performFetch()
            filtered = fetchedResultsController.fetchedObjects ?? []
        } catch {
            print("Fetch error: \(error.localizedDescription)")
        }
        
        // MARK: - Combine Pipeline
        // searchText değiştikçe 300ms debounce uygulayıp filtre fonksiyonunu çağırır.
        $seachText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.filterContent(for: text)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Filtering Logic
    
    /// Arama metnine göre Core Data fetchRequest predicate'i güncelleyip yeniden fetch yapar.
    /// - Parameter searchText: Kullanıcının arama çubuğuna yazdığı metin.
    private func filterContent(for searchText: String) {
        // Arama metni boşsa predicate'i kaldır, değilse contains[cd] ile filtre uygula.
        let predicate: NSPredicate? = searchText.isEmpty
        ? nil
        : NSPredicate(format: "name CONTAINS[cd] %@", searchText)
        
        fetchedResultsController.fetchRequest.predicate = predicate
        
        do {
            try fetchedResultsController.performFetch()
            filtered = fetchedResultsController.fetchedObjects ?? []
        } catch {
            print("Filter error: \(error.localizedDescription)")
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension SearchViewModel: NSFetchedResultsControllerDelegate {
    /// Core Data içerikleri değiştiğinde tetiklenir; `filtered` dizisini günceller.
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        filtered = controller.fetchedObjects as? [Food] ?? []
    }
}
