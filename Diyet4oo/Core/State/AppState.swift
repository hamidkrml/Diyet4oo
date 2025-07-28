//
//  AppState.swift
//  Diyet4oo
//
//  Created by hamid karimli on 28.07.25.
//

import Foundation

class AppState: ObservableObject {
    @Published var isLoading = true
    @Published var showOnboarding = true
    
    // MARK: - Initialization
    init() {
        // AppState initialization logic can be added here if needed
    }
}
