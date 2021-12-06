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
    @Published var passport:String = ""
    @Published var birthDate:Date = Date.now
    @Published var gender:Gender = Gender.Male
    @Published var country: Country? = Country(id: "HU", name: "Hungary")
    
    let context = PersistentContainer.persistentContainer.viewContext
    
    func finishBooking(flightID: String) {
        let newBoardingCard = BoardingCard(context: context)

        newBoardingCard.id = randomString(length: 6)
        newBoardingCard.firstName = firstName
        newBoardingCard.lastName = lastName
        newBoardingCard.passport = passport
        newBoardingCard.birthdate = birthDate
        newBoardingCard.gender = gender.id
        newBoardingCard.country = country!.name
        
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
    
    func randomString(length: Int) -> String {
      let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}
