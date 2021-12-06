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
    
    @FetchRequest(
        entity: BoardingCard.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \BoardingCard.flight?.departureDate, ascending: true)]
    ) var boardingcards: FetchedResults<BoardingCard>
    
    
    private let dateFormatter = DateFormatter()
    
    init() {
        // get location permissions
        if locationViewModel.authorizationStatus == .notDetermined {
            locationViewModel.requestPermission()
        }
        
        dateFormatter.dateFormat = "EEE d MMM, hh:mm"
        
        // hardcoded flights
        //setupFlights()
    }

    
    var body: some View {
            NavigationView {
                ZStack {
                    Image("menu_background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                    
                VStack {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.white)
                            .padding([.leading, .trailing], 20)
                            .frame(width: UIScreen.main.bounds.width, height: 100)
                        
                        if boardingcards.count == 0 || boardingcards[0].flight == nil {
                            Text("You have no upcoming flights.")
                                .font(Font.body.bold())
                        }
                        else {
                            VStack {
                                HStack {
                                    Image(systemName: "airplane.departure")
                                        .foregroundColor(Color.gray)
                                    Text(dateFormatter.string(from: boardingcards[0].flight!.departureDate!))
                                }
                                .font(.system(size: 20))
                                HStack {
                                    Text(boardingcards[0].flight!.startingAirport!.name!)
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(Color.black)
                                    Text(boardingcards[0].flight!.destinationAirport!.name!)
                                }
                                .font(.system(size: 20, weight: .bold))
                                
                            }
                            
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: SearchView(rootIsActive: self.$isActive, searchHandler:searchHandler).environment(\.managedObjectContext, managedObjectContext), isActive: self.$isActive) {
                        Label("Search", systemImage: "magnifyingglass")
                    }.navigationBarTitleDisplayMode(.inline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .clipShape(Capsule())
                        .toolbar(content: {
                             ToolbarItem(placement: .principal, content: {
                             Text("Main Menu")
                             })}).simultaneousGesture(TapGesture().onEnded{
                                 searchHandler.updateLocation()                         })//.navigationTitle("Main Menu")
                    
                    
                    NavigationLink(destination: BoardingCardView()) {
                        Label("Boarding cards", systemImage: "wallet.pass.fill")
                    }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .clipShape(Capsule())
                
                    Spacer()
                }
            
                    
        }.navigationViewStyle(StackNavigationViewStyle())
                
        }

    }
    
    func setupFlights() {
        let context = PersistentContainer.persistentContainer.viewContext
        let bud = Airport(context: context)
        bud.code = "BUD"
        bud.name = "Budapest"
        bud.lat = 47.43699722
        bud.lon = 19.25716667
        let lhr = Airport(context: context)
        lhr.code = "LHR"
        lhr.name = "London"
        lhr.lat = 51.87149722
        lhr.lon = 0.36766389
        let pao = Airport(context: context)
        pao.code = "PAO"
        pao.name = "Palo Alto"
        pao.lat = 37.46111111
        pao.lon = 122.11500000

        let newFlight = Flight(context: context)
        newFlight.id = "BUD1"
        newFlight.startingAirport = bud
        newFlight.destinationAirport = lhr
        newFlight.departureDate = Calendar.current.date(from: DateComponents(year: 2021, month: 12, day: 13, hour: 8, minute: 00))!
        newFlight.arriveDate = Calendar.current.date(from: DateComponents(year: 2021, month: 12, day: 13, hour: 12, minute: 00))!
        
        let newFlight2 = Flight(context: context)
        newFlight2.id = "BUD2"
        newFlight2.startingAirport = bud
        newFlight2.destinationAirport = lhr
        newFlight2.departureDate = Calendar.current.date(from: DateComponents(year: 2021, month: 12, day: 13, hour: 10, minute: 00))!
        newFlight2.arriveDate = Calendar.current.date(from: DateComponents(year: 2021, month: 12, day: 13, hour: 13, minute: 00))!

        let newFlight3 = Flight(context: context)
        newFlight3.id = "LHR1"
        newFlight3.startingAirport = lhr
        newFlight3.destinationAirport = bud
        newFlight3.departureDate = Calendar.current.date(from: DateComponents(year: 2021, month: 12, day: 13, hour: 18, minute: 00))!
        newFlight3.arriveDate = Calendar.current.date(from: DateComponents(year: 2021, month: 12, day: 13, hour: 21, minute: 00))!
        
        let newFlight4 = Flight(context: context)
        newFlight4.id = "LHR2"
        newFlight4.startingAirport = lhr
        newFlight4.destinationAirport = pao
        newFlight4.departureDate = Calendar.current.date(from: DateComponents(year: 2021, month: 12, day: 13, hour: 10, minute: 00))!
        newFlight4.arriveDate = Calendar.current.date(from: DateComponents(year: 2021, month: 12, day: 13, hour: 22, minute: 00))!

        do {
            try context.save()
            print("SAVED")
          } catch {
            print("Error saving managed object context: \(error)")
          }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
