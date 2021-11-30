//
//  BookingHandler.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 29..
//

import Foundation
import CoreData

class BookingHandler: ObservableObject {
    @Published var firstName:String = ""
    @Published var lastName:String = ""
    //private let flightID
    
    // TODO: seat
    
    let context = PersistentContainer.persistentContainer.viewContext
    
    func finishBooking(flightID: String) {
        let newBoardingCard = BoardingCard(context: context)

        newBoardingCard.id = "ASD1"
        newBoardingCard.firstName = firstName
        newBoardingCard.lastName = lastName
        
        // fetch the flight by ID
        let fetchRequest: NSFetchRequest<Flight>
        fetchRequest = Flight.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "id == %@", flightID)

        let flights = try! context.fetch(fetchRequest)
        newBoardingCard.flight = flights[0]
        
        do {
            try context.save()
          } catch {
            print("Error saving managed object context: \(error)")
          }
    }
    
}
