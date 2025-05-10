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
            VStack(spacing: 0) {
                // 🔍 Sabit TextField
                TextField("Yemek ara...", text: $viewModel.searchText1)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding([.horizontal, .top])

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
                        }
                    }
                    .animation(keyboard.isKeyboardVisible ? nil : .default, value: viewModel.filtered)
                    .padding(.horizontal)
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
    }
}

extension View {
    func withoutAnimation() -> some View {
        withAnimation(nil) {
            self
        }
    }
}
