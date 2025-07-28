//
//  appState.swift
//  Diyet4oo
//
//  Created by hamid karimli on 28.07.25.
//


import Foundation
import CoreData

class AppState: ObservableObject {
    @Published var isLoading = true
    @Published var showOnboarding = true
}
