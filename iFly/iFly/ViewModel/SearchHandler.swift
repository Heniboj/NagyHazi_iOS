//
//  SearchHandler.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 27..
//

import Foundation

class SearchHandler: ObservableObject {
    @Published var leavingText:String = ""
    @Published var goingText:String = ""
    
    @Published var departureDate:Date = Date()
    @Published var returnDate:Date = Date().addingTimeInterval(86400)
    
    @Published var foundFlights:[Flight] = []
    @Published var query:SearchQuery = SearchQuery("", "", Date(), Date())
    
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
            if(flight.departureDate > self.departureDate) {
                return true
            }
        }
        return false
    }
}

