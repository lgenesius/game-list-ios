//
//  GameListApp.swift
//  GameList
//
//  Created by Luis Genesius on 15/08/21.
//

import SwiftUI

@main
struct GameListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
