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
class SearchViewModel: NSObject, ObservableObject {
    // MARK: - Constants
    private let fetchLimit: Int = 20

    // MARK: - Published Properties
    @Published var searchText1: String = ""
    @Published var filtered: [Food] = []

    // MARK: - Private Properties
    private let context: NSManagedObjectContext
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init()

        // İlk veri yüklemesi (arama kutusu boşken)
        filterContent(for: "")

        // Arama metni değişimlerini takip et
        $searchText1
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.filterContent(for: text)
            }
            .store(in: &cancellables)
    }

    // MARK: - Fetch & Filter
    private func filterContent(for text: String) {
        let request: NSFetchRequest<Food> = Food.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        request.fetchLimit = text.isEmpty ? fetchLimit : 0

        if !text.isEmpty {
            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", text)
        }

        DispatchQueue.global(qos: .userInitiated).async {
            let result: [Food]
            do {
                result = try self.context.fetch(request)
            } catch {
                print("Fetch error: \(error.localizedDescription)")
                return
            }

            DispatchQueue.main.async {
                self.filtered = result
            }
        }
    }
}
