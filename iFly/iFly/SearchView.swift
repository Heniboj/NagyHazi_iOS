//
//  SearchView.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 09..
//

import SwiftUI

struct SearchView: View {
    @State private var leavingText:String = ""
    @State private var goingText:String = ""
    
    @State private var departureDate:Date = Date()
    @State private var returnDate:Date = Date().addingTimeInterval(86400)
    
    var body: some View {
        VStack {
            VStack {
                TextField("Leaving from", text:$leavingText).textFieldStyle(.roundedBorder).font(Font.system(size: 25, design: .default))
                TextField("Going to", text:$goingText).textFieldStyle(.roundedBorder).font(Font.system(size: 25, design: .default))
                
                VStack {
                    HStack {
                        Text("Departure").frame(maxWidth: .infinity, alignment: .leading).padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
                        Text("Return").frame(maxWidth: .infinity, alignment: .leading).padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
                }
                    HStack {
                        DatePicker("", selection: $departureDate,displayedComponents: [.date]).labelsHidden().frame(maxWidth: .infinity, alignment: .leading).accentColor(Color.purple)
                    
                        DatePicker("", selection: $returnDate,displayedComponents: [.date]).labelsHidden().frame(maxWidth: .infinity, alignment: .leading).accentColor(Color.purple)
                    }.padding(EdgeInsets(top: -20, leading: 0, bottom: 0, trailing: 0))
                }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            
            }.padding(EdgeInsets(top: 50, leading: 50, bottom: 0, trailing: 50)).preferredColorScheme(.light)
            
            
            //NavigationView {
            NavigationLink(destination: SearchResultView(leavingText: leavingText, goingText: goingText, departureDate: departureDate, returnDate: returnDate)) {
                    Text("Search Flights")
                }
            //}
            
            
            Spacer()
            
        }.background(Color.purple).navigationTitle("Search").navigationBarTitleDisplayMode(.inline)
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchView()
                .previewDevice("iPhone 13")
            .previewInterfaceOrientation(.portrait)
            SearchView()
                .previewDevice("iPhone 11")
                .previewInterfaceOrientation(.portrait)
        }
    }
}
