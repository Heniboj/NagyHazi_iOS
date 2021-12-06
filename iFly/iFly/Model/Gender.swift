//
//  Gender.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 12. 06..
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case Male
    case Female

    var id: String { self.rawValue }
}
