//
//  SearchResultView.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 23..
//

import SwiftUI

struct SearchResultView: View {
    let foundFlights:[Flight]
    let query:SearchQuery
    //private let df = DateFormatter().dateFormat =
    
    
    var body: some View {
        //df.dateFormat =
        List(foundFlights) { flight in
            VStack {
                NavigationLink(destination: ContentView()) {
                    Text(flight.id)
                    //Text("sjfwoirgjoerjeiopjrepvroijvjeer")
                    Text(dateformatter.string(from:flight.departureDate))
                            
                            
                }
            }
                
                    
                
                        
        }
            

    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(foundFlights:[Flight(id: "BUD1", startingAirport: "Budapest", destinationAirport: "London Luton", departureDate: Calendar.current.date(from: DateComponents(year: 2021, month: 11, day: 29, hour: 8, minute: 00))! , arriveDate: Calendar.current.date(from: DateComponents(year: 2021, month: 11, day: 29, hour: 8, minute: 00))!)], query:SearchQuery("Budapest", "London Luton", Calendar.current.date(from: DateComponents(year: 2021, month: 11, day: 29, hour: 8, minute: 00))!, Calendar.current.date(from: DateComponents(year: 2021, month: 11, day: 29, hour: 8, minute: 00))!))
    }
}
