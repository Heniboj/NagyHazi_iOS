//
//  SearchQuery.swift.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 27..
//

import Foundation

class SearchQuery {
    private let leavingText:String
    private let goingText:String
    private let departureDate:Date
    private let returnDate:Date
    
    init(_ l:String, _ g:String, _ d:Date, _ r:Date) {
        self.leavingText = l
        self.goingText = g
        self.departureDate = d
        self.returnDate = r
    }
}
