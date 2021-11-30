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
    
    // TODO: seat
    
    let context = PersistentContainer.persistentContainer.viewContext
    
    func finishBooking() {
        let newBoardingCard = BoardingCard(context: context)

        newBoardingCard.id = "ASD1"
        newBoardingCard.firstName = firstName
        newBoardingCard.lastName = lastName
        
        do {
            try context.save()
          } catch {
            print("Error saving managed object context: \(error)")
          }
    }
    
}
