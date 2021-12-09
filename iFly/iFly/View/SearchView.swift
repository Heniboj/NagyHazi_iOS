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
    @Binding var rootIsActive: Bool
    @State var searchIsActive: Bool = false
    
    @ObservedObject var searchHandler:SearchHandler
    @State private var isOneWay = false
    
    var body: some View {
        VStack {
            VStack {
                Group {
                    TextField("Leaving from", text:$searchHandler.leavingText)
                    TextField("Going to", text:$searchHandler.goingText)
                        .onAppear {
                            searchHandler.goingText = ""
                        }
                }
                .textFieldStyle(.roundedBorder)
                .font(Font.system(size: 25, design: .default))
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    
                    VStack {
                        HStack {
                            Text("Departure")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
                                .foregroundColor(Color.gray)
                            if !isOneWay {
                                Text("Return")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
                                    .foregroundColor(Color.gray)
                            }
                        }
                        HStack {
                            DatePicker("", selection: $searchHandler.departureDate,displayedComponents: [.date])
                                .labelsHidden()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .accentColor(Color.purple)

                            if !isOneWay {
                                DatePicker("", selection: $searchHandler.returnDate,displayedComponents: [.date])
                                    .labelsHidden()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .accentColor(Color.purple)
                            }
                        }.padding(EdgeInsets(top: -20, leading: 0, bottom: 0, trailing: 0))
                    }.padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
                }
                     
                ZStack {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    
                    HStack {
                        Toggle("One way", isOn: $isOneWay)
                            .foregroundColor(Color.gray)
                            .toggleStyle(MyToggleStyle())
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
                    }
                }
                    
                
            
            }.padding(EdgeInsets(top: 50, leading: 50, bottom: 0, trailing: 50))
            
            Button(action: {searchIsActive = true}) {
                Label("Search Flights", systemImage: "magnifyingglass")
            }
            .padding()
            .background(Color.purple)
            .foregroundColor(Color.white)
            .clipShape(Capsule())
            
            
            NavigationLink(destination: SearchResultView(rootIsActive: self.$rootIsActive, searchIsActive: self.$searchIsActive, searchHandler: searchHandler, isOneWay: isOneWay), isActive: $searchIsActive) {
                
            }.isDetailLink(false)
            
            Spacer()
        }
        .background(
            Image("search_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        )
        .ignoresSafeArea(.keyboard)
        //.background(Color.purple)//.navigationTitle("Search").navigationBarTitleDisplayMode(.inline)
        
    }
}
