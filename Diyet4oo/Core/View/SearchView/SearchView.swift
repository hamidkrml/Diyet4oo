//
//  SearchView.swift
//  Diyet4oo
//
//  Created by hamid karimli on 6.05.2025.
//

import SwiftUI

struct SearchView: View {
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel: SearchViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject private var keyboard = KeyboardObserver()
    
    // MARK: - Initialization
    init() {
        _viewModel = StateObject(wrappedValue: SearchViewModel(context: CoreDataManager.shared.persistentContainer.viewContext))
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                searchBar
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else {
                    searchResults
                }
            }
            .navigationTitle("Yemekler")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                BackToolbarItem(dismiss: dismiss)
            }
            .background(
                Color(.systemBackground)
                    .ignoresSafeArea()
            )
        }
        .navigationViewStyle(.stack)
        .toolbar(.hidden, for: .tabBar)
    }
    
    // MARK: - UI Components
    
    private var searchBar: some View {
        TextField("Yemek ara...", text: $viewModel.searchText1)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding([.horizontal, .top])
    }
    
    private var searchResults: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                if viewModel.filtered.isEmpty {
                    emptyStateView
                } else {
                    resultsList
                }
            }
            .animation(keyboard.isKeyboardVisible ? nil : .default, value: viewModel.filtered)
            .padding(.horizontal)
        }
    }
    
    private var emptyStateView: some View {
        Text("Sonuç bulunamadı")
            .foregroundColor(.gray)
            .padding()
    }
    
    private var resultsList: some View {
        ForEach(viewModel.filtered, id: \.self) { food in
            NavigationLink(destination: SearchDetailView(food: food)) {
                Searchuserfotoname(food: food)
                    .padding(.vertical, 8)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    SearchView()
}

extension View {
    func withoutAnimation() -> some View {
        withAnimation(nil) {
            self
        }
    }
}
