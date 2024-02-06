//
//  ToDoCRUDApp.swift
//  ToDoCRUD
//
//  Created by Илья on 04.02.2024.
//

import SwiftUI

@main
struct ToDoCRUDApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                persistenceController.container.viewContext)
        }
    }
}
