//
//  ContentView.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 08..
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var isActive: Bool = false
    
    @ObservedObject var searchHandler:SearchHandler = SearchHandler()
    var locationViewModel = LocationViewModel()
    
    init() {
        // get location permissions
        if locationViewModel.authorizationStatus == .notDetermined {
            locationViewModel.requestPermission()
        }
    }

    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SearchView(rootIsActive: self.$isActive, searchHandler:searchHandler).environment(\.managedObjectContext, managedObjectContext), isActive: self.$isActive) {
                    Text("Search")
                }.navigationBarTitleDisplayMode(.inline)
                    .toolbar(content: {
                         ToolbarItem(placement: .principal, content: {
                         Text("Main Menu")
                         })}).simultaneousGesture(TapGesture().onEnded{
                             searchHandler.updateLocation()                         })//.navigationTitle("Main Menu")

                NavigationLink(destination: BoardingCardView()) {
                    Text("Boarding cards")
                }
            
                
                

                
            }

        }.onAppear {
//            let context = PersistentContainer.persistentContainer.viewContext
//            let bud = Airport(context: context)
//            bud.code = "BUD"
//            bud.name = "Budapest"
//            bud.lat = 47.43699722
//            bud.lon = 19.25716667
//            let nur = Airport(context: context)
//            nur.code = "LTN"
//            nur.name = "London Luton"
//            nur.lat = 51.87149722
//            nur.lon = 0.36766389
//
//
//
//
//            let newFlight = Flight(context: context)
//
//            newFlight.id = "BUD2"
//            newFlight.startingAirport = bud
//            newFlight.destinationAirport = nur
//            newFlight.departureDate = Calendar.current.date(from: DateComponents(year: 2021, month: 12, day: 13, hour: 8, minute: 00))!
//            newFlight.arriveDate = Calendar.current.date(from: DateComponents(year: 2021, month: 12, day: 13, hour: 12, minute: 00))!
//
//
//            do {
//                try context.save()
//              } catch {
//                print("Error saving managed object context: \(error)")
//              }
        }.navigationViewStyle(StackNavigationViewStyle())

    }
    
}

struct RequestLocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "location.circle")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(.blue
                )
            Button(action: {
                locationViewModel.requestPermission()
            }, label: {
                Label("Allow tracking", systemImage: "location")
            })
            .padding(10)
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            Text("We need your permission to track you.")
                .foregroundColor(.gray)
                .font(.caption)
        }
    }
}

struct ErrorView: View {
    var errorText: String
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                    .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            Text(errorText)
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.red)
    }
}

struct TrackingView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        Text("Thanks!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
