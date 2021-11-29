//
//  SearchHandler.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 27..
//

import Foundation
import CoreData

class SearchHandler: ObservableObject {
    @Published var leavingText:String = ""
    @Published var goingText:String = ""
    
    @Published var departureDate:Date = Date()
    @Published var returnDate:Date = Date().addingTimeInterval(86400)
    
    @Published var foundFlights:[Flight] = []
    @Published var query:SearchQuery = SearchQuery("", "", Date(), Date())
    
    private var flights:[Flight]
    
    init() {
        let fetchRequest: NSFetchRequest<Flight>
        fetchRequest = Flight.fetchRequest()

        let context = PersistentContainer.persistentContainer.viewContext

        flights = try! context.fetch(fetchRequest)
    }
    
    func search() {
        foundFlights = []
        query = SearchQuery(leavingText, goingText, departureDate, returnDate)
        for flight in flights {
            if(compareFlight(flight:flight)) {
                foundFlights.append(flight)
            }
        }
    }
    
    func compareFlight(flight:Flight) -> Bool {
        if(flight.startingAirport == self.leavingText && flight.destinationAirport == self.goingText) {
            if(flight.departureDate! > self.departureDate) {
                return true
            }
        }
        return false
    }
    
}

