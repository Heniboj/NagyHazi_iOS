//
//  DottedLine.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 12. 06..
//

import Foundation
import SwiftUI

struct DottedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
