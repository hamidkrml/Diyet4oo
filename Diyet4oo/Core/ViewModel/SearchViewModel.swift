//
//  SwiftUIView.swift
//  Diyet4oo
//
//  Created by hamid karimli on 6.05.2025.
//
import CoreData
import Combine
import SwiftUI

/// ViewModel sınıfı, Core Data'dan `Food` entity'sini çekip arama metnine göre filtreleme yapar.
class SearchViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    // MARK: - Constants
    private let fetchLimit: Int = 20

    // MARK: - Published Properties
    @Published var searchText: String = ""
    @Published var filtered: [Food] = []

    // MARK: - Private Properties
    private let context: NSManagedObjectContext
    private var cancellables = Set<AnyCancellable>()
    private var fetchedResultsController: NSFetchedResultsController<Food>

    // MARK: - Initialization
    init(context: NSManagedObjectContext) {
        self.context = context

        // 1. Fetch Request
        let fetchRequest: NSFetchRequest<Food> = Food.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        fetchRequest.fetchLimit = fetchLimit
        fetchRequest.fetchBatchSize = fetchLimit

        // 2. FetchedResultsController setup
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )

        super.init()
        fetchedResultsController.delegate = self

        // 3. Initial fetch
        performFetchAndPublish()

        // 4. Combine pipeline for search text
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.filterContent(for: text)
            }
            .store(in: &cancellables)
    }

    // MARK: - Fetch & Filter
    private func filterContent(for searchText: String) {
        // Predicate
        if searchText.isEmpty {
            fetchedResultsController.fetchRequest.predicate = nil
            fetchedResultsController.fetchRequest.fetchLimit = fetchLimit
        } else {
            fetchedResultsController.fetchRequest.predicate = NSPredicate(
                format: "name CONTAINS[cd] %@", searchText
            )
            fetchedResultsController.fetchRequest.fetchLimit = 0 // unlimited
        }
        performFetchAndPublish()
    }

    private func performFetchAndPublish() {
        DispatchQueue.global(qos: .userInitiated).async{
            do {
                try self.fetchedResultsController.performFetch()
                let results = self.fetchedResultsController.fetchedObjects ?? []
                DispatchQueue.main.async {
                    withAnimation {
                        self.filtered = results
                    }
                }
            } catch {
                print("Core Data fetch error: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - NSFetchedResultsControllerDelegate
    func controllerDidChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>
    ) {
        // Eğer Core Data'da dışarıdan değişiklikler olursa
        DispatchQueue.main.async {
            self.filtered = (controller.fetchedObjects as? [Food]) ?? []
        }
    }
}
