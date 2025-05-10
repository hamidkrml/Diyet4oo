//
//  SearchView.swift
//  Diyet4oo
//
//  Created by hamid karimli on 6.05.2025.
//

import SwiftUI
import SwiftUI

struct SearchView: View {
    
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel: SearchViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject private var keyboard = KeyboardObserver()
    
    init() {
        _viewModel = StateObject(wrappedValue: SearchViewModel(context: CoreDataManager.shared.persistentContainer.viewContext))
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack {
                    if viewModel.filtered.isEmpty {
                        Text("Sonuç bulunamadı")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(viewModel.filtered, id: \.self) { food in
                            NavigationLink(destination: SearchDetailView(food: food)) {
                                Searchuserfotoname(food: food)
                                    .padding(.vertical, 8)
                            }
                        }
                        // Performans için sabit padding
                        
                    }
                }
                .animation(keyboard.isKeyboardVisible ? nil : .default, value: viewModel.filtered)
                .animation(keyboard.isKeyboardVisible ? nil : .default, value: viewModel.searchText)

                .navigationTitle("Yemekler")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $viewModel.searchText, prompt: "Yemek ara...") // Doğru pozisyon
                .toolbar {
                    BackToolbarItem(dismiss: dismiss)
                }
            }
            .navigationViewStyle(.stack) // Kritik iOS 15+ düzeltme
            .background(
                Color(.systemBackground)
                    .ignoresSafeArea()
            )
        }
    }
}
