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
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SearchView(rootIsActive: self.$isActive).environment(\.managedObjectContext, managedObjectContext), isActive: self.$isActive) {
                    Text("Search")
                }.navigationBarTitleDisplayMode(.inline)
                    .toolbar(content: {
                         ToolbarItem(placement: .principal, content: {
                         Text("Main Menu")
                         })})//.navigationTitle("Main Menu")

                NavigationLink(destination: BoardingCardView()) {
                    Text("Boarding cards")
                }
            }

        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
