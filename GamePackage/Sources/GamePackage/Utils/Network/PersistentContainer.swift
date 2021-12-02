//
//  File.swift
//  
//
//  Created by Luis Genesius on 30/11/21.
//

import Foundation
import CoreData

public struct PersistentContainer {
    
    public static var viewContext: NSManagedObjectContext? = {
        guard let modelURL = Bundle.module.url(forResource: "GameData", withExtension: "momd") else { return nil }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else { return nil }
        let container = NSPersistentContainer(name: "GameData", managedObjectModel: model)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container.viewContext
    }()
}
