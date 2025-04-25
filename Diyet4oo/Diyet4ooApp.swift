//
//  Diyet4ooApp.swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI

@main
struct Diyet4ooApp: App {
    //let persistenceController = PersistenceController.shared
    @StateObject var vm = RegistrationViewModel()
    var body: some Scene {
        WindowGroup {
            CinsiyetInputView()
                .environmentObject(vm)
               // .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
