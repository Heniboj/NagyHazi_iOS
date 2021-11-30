//
//  BookingView.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 27..
//

import SwiftUI

struct BookingView: View {
    @Binding var rootIsActive: Bool
    
    private let flightID: String
    @ObservedObject var bookingHandler:BookingHandler = BookingHandler()

    init(flightID: String, rootIsActive: Binding<Bool>) {
        self.flightID = flightID
        self._rootIsActive = rootIsActive
    }
    
    var body: some View {
        VStack {
            TextField("First Name", text: $bookingHandler.firstName)
            TextField("Last Name", text: $bookingHandler.lastName)
            
            Button (action: { bookingHandler.finishBooking(); self.rootIsActive = false } ){
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
