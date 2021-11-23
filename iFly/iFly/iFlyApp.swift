//
//  iFlyApp.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 08..
//

import SwiftUI

var flights: [Flight] = [Flight(id: "BUD1", startingAirport: "Budapest", destinationAirport: "London Luton", departureDate: Calendar.current.date(from: DateComponents(year: 2021, month: 11, day: 29, hour: 8, minute: 00))! , arriveDate: Calendar.current.date(from: DateComponents(year: 2021, month: 11, day: 29, hour: 8, minute: 00))!)]


@main
struct iFlyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
