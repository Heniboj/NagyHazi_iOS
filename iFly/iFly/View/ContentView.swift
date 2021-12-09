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
    
    @State var isActiveBoardingCardView: Bool = false
    @State var showAlert: Bool = false
    
    init() {
        // get location permissions
        if locationViewModel.authorizationStatus == .notDetermined {
            locationViewModel.requestPermission()
        }
        
        dateFormatter.dateFormat = "EEE d MMM, hh:mm"
    }

    
    var body: some View {
        NavigationView {
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
                             searchHandler.updateLocation()
                             searchHandler.updateFlights()
                         })//.navigationTitle("Main Menu")
                
                
                Button(action: {
                    if boardingcards.count != 0 {
                        isActiveBoardingCardView = true
                    } else {
                        showAlert = true
                    }
                        })
                {
                    Label("Boarding cards", systemImage: "wallet.pass.fill")
                }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .clipShape(Capsule())
                    .alert("You have no Boarding Cards.", isPresented: $showAlert) {
                                Button("OK", role: .cancel) { }
                     }
                
                NavigationLink(destination: BoardingCardView(), isActive: $isActiveBoardingCardView) {
                    
                }
                    
            
                Spacer()
            }
            .background(
                Image("menu_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            )
        
                
    }.navigationViewStyle(StackNavigationViewStyle())
                
    }
    
}
