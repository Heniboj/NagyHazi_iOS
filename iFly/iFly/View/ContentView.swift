//
//  ContentView.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 08..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: SearchView()) {
                Text("Search")
            }.navigationTitle("Main menu").navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
