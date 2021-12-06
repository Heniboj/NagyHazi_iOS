//
//  PresistentContainer.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 27..
//

import Foundation
import CoreData

class PersistentContainer {
    public static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    public static var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "iFly")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    // MARK: - Core Data Saving support
    public static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
