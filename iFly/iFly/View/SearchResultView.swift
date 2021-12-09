//
//  SearchResultView.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 23..
//

import SwiftUI

struct SearchResultView: View {
    @Binding var rootIsActive: Bool
    @Binding var searchIsActive: Bool
    
    var searchHandler:SearchHandler
    let isOneWay:Bool
    
    @State var showAlert: Bool = false
    
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
        .onAppear {
            if searchHandler.getFoundFlightCount() == 0 {
                showAlert = true
            }
        }
        .alert("No flights found.", isPresented: $showAlert) {
            Button("OK", role: .cancel) {self.searchIsActive = false }
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
