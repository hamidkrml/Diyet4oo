//
//  Diyet4ooApp.swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//
import SwiftUI

@main
struct Diyet4ooApp: App {
    @StateObject private var appState = AppState()
    @StateObject var viewModel = InputViewModel()
    let coreData = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if appState.isLoading {
                    ProgressView("Yükleniyor...")
                        .transition(.opacity)
                } else {
                    if appState.showOnboarding {
                        Onboarding()
                            .environmentObject(appState)
                    } else {
                        MainTabView()
                    }
                }
            }
            .environmentObject(viewModel)
            .environment(\.managedObjectContext, coreData.persistentContainer.viewContext)
            .onAppear {
                // Core Data hazır olduğunda onboarding durumunu kontrol et
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    appState.showOnboarding = !coreData.isOnboardingCompleted()
                    appState.isLoading = false
                }
            }
        }
    }
}

// AppState.swift (Yeni dosya)
