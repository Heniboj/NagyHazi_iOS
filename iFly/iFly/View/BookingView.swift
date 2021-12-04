//
//  BookingView.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 27..
//

import SwiftUI

struct BookingView: View {
    @Binding var rootIsActive: Bool
    
    private let flightID1: String
    private var flightID2: String? = nil
    @ObservedObject var bookingHandler:BookingHandler = BookingHandler()
    
    init(flightID1: String, rootIsActive: Binding<Bool>) {
        self.flightID1 = flightID1
        self._rootIsActive = rootIsActive
    }
    
    init(flightID1: String, flightID2: String, rootIsActive: Binding<Bool>) {
        self.flightID1 = flightID1
        self.flightID2 = flightID2
        self._rootIsActive = rootIsActive
    }

    var body: some View {
        VStack {
            TextField("First Name", text: $bookingHandler.firstName)
            TextField("Last Name", text: $bookingHandler.lastName)
            
            Button (action: {
                bookingHandler.finishBooking(flightID: flightID1)
                if flightID2 != nil {
                    bookingHandler.finishBooking(flightID: flightID2!)
                }
                self.rootIsActive = false
            } ){
                Text("Confirm")
            }
            
           
            
        }
    }
}

//struct BookingView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookingView(flightID: "BUD1", rootIsActive: Binding<Bool>(false))
//    }
//}
