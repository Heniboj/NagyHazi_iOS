//
//  SearchView.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 09..
//

import SwiftUI
import CoreData

struct SearchView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var searchHandler:SearchHandler = SearchHandler()
    @State private var isActive = false
    
    var body: some View {
        VStack {
            VStack {
                TextField("Leaving from", text:$searchHandler.leavingText).textFieldStyle(.roundedBorder).font(Font.system(size: 25, design: .default))
                TextField("Going to", text:$searchHandler.goingText).textFieldStyle(.roundedBorder).font(Font.system(size: 25, design: .default))
                
                VStack {
                    HStack {
                        Text("Departure").frame(maxWidth: .infinity, alignment: .leading).padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
                        Text("Return").frame(maxWidth: .infinity, alignment: .leading).padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
                }
                    HStack {
                        DatePicker("", selection: $searchHandler.departureDate,displayedComponents: [.date]).labelsHidden().frame(maxWidth: .infinity, alignment: .leading).accentColor(Color.purple)
                    
                        DatePicker("", selection: $searchHandler.returnDate,displayedComponents: [.date]).labelsHidden().frame(maxWidth: .infinity, alignment: .leading).accentColor(Color.purple)
                    }.padding(EdgeInsets(top: -20, leading: 0, bottom: 0, trailing: 0))
                }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            
            }.padding(EdgeInsets(top: 50, leading: 50, bottom: 0, trailing: 50)).preferredColorScheme(.light)
            
            

            Button(action: {searchHandler.search(); isActive = true}) {
                Text("Search Flights")
                
            }
            NavigationLink(destination: SearchResultView(foundFlights: searchHandler.foundFlights, query: searchHandler.query), isActive: $isActive) {
                
            }
            
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
