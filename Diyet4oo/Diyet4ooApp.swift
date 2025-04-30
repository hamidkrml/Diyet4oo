//
//  Diyet4ooApp.swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI

@main
struct Diyet4ooApp: App {
    let Coredata = CoreDataManager.shared.viewContext
    @StateObject var viewModel = InputViewModel()
    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environmentObject(viewModel)
                .environment(\.managedObjectContext, Coredata)
        }
    }
}
