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
@MainActor
class SearchViewModel: NSObject, ObservableObject {
    // MARK: - Constants
    private let fetchLimit: Int = 20
    private let searchDebounceTime: TimeInterval = 0.3

    // MARK: - Published Properties
    @Published var searchText1: String = ""
    @Published var filtered: [Food] = []
    @Published var isLoading: Bool = false

    // MARK: - Private Properties
    private let context: NSManagedObjectContext
    private var cancellables = Set<AnyCancellable>()
    private var searchTask: Task<Void, Never>?

    // MARK: - Initialization
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init()
        setupSearchSubscription()
        Task {
            await loadInitialData()
        }
    }

    // MARK: - Setup
    private func setupSearchSubscription() {
        $searchText1
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.searchTask?.cancel()
                self?.searchTask = Task {
                    await self?.filterContent(for: text)
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - Data Loading
    private func loadInitialData() async {
        await filterContent(for: "")
    }

    // MARK: - Fetch & Filter
    private func filterContent(for text: String) async {
        guard !Task.isCancelled else { return }
        
        isLoading = true
        defer { isLoading = false }

        let request: NSFetchRequest<Food> = Food.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        request.fetchLimit = text.isEmpty ? fetchLimit : 0

        if !text.isEmpty {
            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", text)
        }

        do {
            let result = try await context.perform {
                try self.context.fetch(request)
            }
            if !Task.isCancelled {
                self.filtered = result
            }
        } catch {
            print("Fetch error: \(error.localizedDescription)")
        }
    }

    @MainActor
    func performSearch(_ text: String) async {
        await filterContent(for: text)
    }
}
