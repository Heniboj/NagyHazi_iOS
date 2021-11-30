//
//  ContentView.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 08..
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SearchView(rootIsActive: self.$isActive).environment(\.managedObjectContext, managedObjectContext), isActive: self.$isActive) {
                    Text("Search")
                }.navigationBarTitleDisplayMode(.inline)
                    .toolbar(content: {
                         ToolbarItem(placement: .principal, content: {
                         Text("Main Menu")
                         })})//.navigationTitle("Main Menu")

                NavigationLink(destination: BoardingCardView()) {
                    Text("Boarding cards")
                }
            }

        }.onAppear {
//            let context = PersistentContainer.persistentContainer.viewContext
//            let bud = Airport(context: context)
//            bud.code = "BUD"
//            bud.name = "Budapest"
//            let nur = Airport(context: context)
//            nur.code = "NQZ"
//            nur.name = "Nur Sultan"
//
//
//
//
//            let newFlight = Flight(context: context)
//
//            newFlight.id = "BUD2"
//            newFlight.startingAirport = bud
//            newFlight.destinationAirport = nur
//            newFlight.departureDate = Calendar.current.date(from: DateComponents(year: 2021, month: 12, day: 13, hour: 8, minute: 00))!
//            newFlight.arriveDate = Calendar.current.date(from: DateComponents(year: 2021, month: 12, day: 13, hour: 12, minute: 00))!
//
//
//            do {
//                try context.save()
//              } catch {
//                print("Error saving managed object context: \(error)")
//              }
        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
