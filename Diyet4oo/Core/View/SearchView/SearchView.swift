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
                            Searchuserfotoname(food: food)
                                .padding(.vertical, 8)
                        }
                        // Performans için sabit padding
                        
                    }
                }
                .navigationTitle("Yemekler")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $viewModel.seachText, prompt: "Yemek ara...") // Doğru pozisyon
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
