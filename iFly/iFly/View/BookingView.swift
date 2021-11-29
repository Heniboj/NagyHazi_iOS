//
//  BookingView.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 27..
//

import SwiftUI

struct BookingView: View {
    @State var firstName = ""
    var body: some View {
        VStack {
            TextField("First Name", text: $firstName)
            
        }
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
