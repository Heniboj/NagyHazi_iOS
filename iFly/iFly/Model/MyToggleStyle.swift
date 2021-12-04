//
//  MyToggleStyle.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 12. 03..
//

import Foundation
import SwiftUI

struct MyToggleStyle: ToggleStyle {
    var onColor = Color(UIColor.purple)
    var offColor = Color(UIColor.purple)
    var thumbColor = Color.white
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .fill(configuration.isOn ? onColor : offColor)
                .frame(width: 50, height: 29)
                .overlay(
                    Circle()
                        .fill(thumbColor)
                        .shadow(radius: 1, x: 0, y: 1)
                        .padding(1.5)
                        .offset(x: configuration.isOn ? 10 : -10))
                .onTapGesture { configuration.isOn.toggle() }
                .animation(Animation.easeInOut(duration: 0.2), value: configuration.isOn)
                
        }
        .font(.title)
        .padding(.horizontal)
    }
}
