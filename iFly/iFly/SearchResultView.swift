//
//  SearchResultView.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 23..
//

import SwiftUI

struct SearchResultView: View {
    let leavingText:String
    let goingText:String
    
    let departureDate:Date
    let returnDate:Date
    
    var body: some View {
        VStack {
            Text("\(leavingText)")
            Text("\(goingText)")
            Text("\(departureDate)")
            Text("\(returnDate)")
        }
        
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(leavingText: "Preview Airport 1", goingText: "Preview Airport 2", departureDate: Date(), returnDate: Date())
    }
}
