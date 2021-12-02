//
//  SearchHandler.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 27..
//

import Foundation
import CoreData
import CoreLocation

class SearchHandler: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var leavingText:String = ""
    @Published var goingText:String = ""
    
    @Published var departureDate:Date = Date()
    @Published var returnDate:Date = Date().addingTimeInterval(86400)
    
    @Published var foundFlights:[Flight] = []
    @Published var query:SearchQuery = SearchQuery("", "", Date(), Date())
    
    
    var locationViewModel = LocationViewModel()
    
    private var flights:[Flight] = []
    
    override init() {
        super.init()
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
        if(flight.startingAirport!.name == self.leavingText && flight.destinationAirport!.name == self.goingText) {
            if(flight.departureDate! > self.departureDate) {
                return true
            }
        }
        return false
    }
    
    func searchClosestAirport(latitude:Double, longitude:Double) -> String {
        // fetch airports
        let fetchRequest: NSFetchRequest<Airport>
        fetchRequest = Airport.fetchRequest()
        let context = PersistentContainer.persistentContainer.viewContext
        let airports:[Airport] = try! context.fetch(fetchRequest)
        
        let currentLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        var smallestDistance:Double = 12756000.0 // egyenlito
        var index = 0
        for i in 0...airports.count-1 {
            let distanceInMeters = currentLocation.distance(from: CLLocation(latitude: airports[i].lat, longitude: airports[i].lon))
            if distanceInMeters < smallestDistance {
                smallestDistance = distanceInMeters
                index = i
            }
        }
        print("CLOSEST: \(airports[index].name!)")
        return airports[index].name!
    }
    
    func updateLocation() {
        switch locationViewModel.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            if locationViewModel.latitude != nil && locationViewModel.longitude != nil {
                self.leavingText = searchClosestAirport(latitude: locationViewModel.latitude!, longitude: locationViewModel.longitude!)
                break
            }
            self.leavingText = ""
                
            default:
                self.leavingText = ""
        }
    
    }
}

