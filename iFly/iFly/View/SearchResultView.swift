//
//  SearchResultView.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 23..
//

import SwiftUI

struct SearchResultView: View {
    @Binding var rootIsActive: Bool
    
    var searchHandler:SearchHandler
    let isOneWay:Bool
    
    var body: some View {
        List(searchHandler.search(isReturn: false)) { flight in
            VStack {
                NavigationLink(destination: getDestination(flight: flight)) {
                    Text(flight.id!)
                    Text(dateformatter.string(from:flight.departureDate!))
                }
            }
        }
    }
    
    func getDestination(flight: Flight) -> AnyView {
            if isOneWay {
                return AnyView(BookingView(flightID1: flight.id!, rootIsActive: self.$rootIsActive))
            } else {
                return AnyView(ReturnFlightResultView(rootIsActive: self.$rootIsActive, flightID: flight.id!, searchHandler: searchHandler))
            }
        }
}

//struct SearchResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchResultView(foundFlights: [], query: SearchQuery("", "", Date(), Date()), rootIsActive: false)
//    }
//}
