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
    
    var body: some View {
        List(foundFlights) { flight in
            VStack {
                NavigationLink(destination: ContentView()) {
                    Text(flight.id!)
                    Text(dateformatter.string(from:flight.departureDate!))


                }
            }
            
        }
            

    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(foundFlights: [], query: SearchQuery("", "", Date(), Date()))
    }
}
