//
//  ReturnFlightResultView.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 12. 04..
//

import SwiftUI

struct ReturnFlightResultView: View {
    @Binding var rootIsActive: Bool
    let flightID: String
    var searchHandler:SearchHandler

    var body: some View {
        List(searchHandler.search(isReturn: true)) { flight in
            VStack {
                NavigationLink(destination: BookingView(flightID1: flightID, flightID2: flight.id!, rootIsActive: self.$rootIsActive)) {
                    Text(flight.id!)
                    Text(dateformatter.string(from:flight.departureDate!))
                }
            }
        }
    }
    

}

//struct ReturnFlightResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReturnFlightResultView()
//    }
//}
