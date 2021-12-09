//
//  iFlyApp.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 08..
//

import SwiftUI
import CoreData

var dateformatter = DateFormatter()

@main
struct iFlyApp: App {
    
    let managedObjectContext = PersistentContainer.persistentContainer.viewContext
    
    var body: some Scene {
        
        WindowGroup {
            ContentView().environment(\.managedObjectContext, managedObjectContext)
        }
    }
}
