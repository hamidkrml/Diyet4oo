//
//  Diyet4ooApp.swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI

@main
struct Diyet4ooApp: App {
    var coreData = CoreDataManager.shared
    @StateObject var viewModel = InputViewModel()
    
    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environmentObject(viewModel)
                .environment(\.managedObjectContext, coreData.persistentContainer.viewContext)
<<<<<<< HEAD
                .onAppear{
                    print("mkgfkmsd")
                    coreData.initializeData()
                }
=======
                
>>>>>>> a44f889 (succses)
            
        }
    }
} 
