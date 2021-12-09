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
                    HStack {
                        Spacer()
                        VStack {
                            Text(flight.id!)
                            HStack {
                                Text(flight.startingAirport!.code!)
                                Image(systemName: "arrow.right")
                                    .foregroundColor(Color.black)
                                Text(flight.destinationAirport!.code!)
                            }
                            Text(dateformatter.string(from:flight.departureDate!))
                        }
                        Spacer()
                    }
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
