//
//  BookingView.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 27..
//

import SwiftUI

struct BookingView: View {
    @Binding var rootIsActive: Bool
    
    private let flightID1: String
    private var flightID2: String? = nil
    @ObservedObject var bookingHandler:BookingHandler = BookingHandler()
    
    let countries = Locale.isoRegionCodes.compactMap{ Country(id: $0, name: Locale.current.localizedString(forRegionCode: $0)!) }
    
    init(flightID1: String, rootIsActive: Binding<Bool>) {
        self.flightID1 = flightID1
        self._rootIsActive = rootIsActive
    }
    
    init(flightID1: String, flightID2: String, rootIsActive: Binding<Bool>) {
        self.flightID1 = flightID1
        self.flightID2 = flightID2
        self._rootIsActive = rootIsActive
    }
    
    
    var body: some View {
        VStack {
            Group {
                TextField("First Name", text: $bookingHandler.firstName)
                TextField("Last Name", text: $bookingHandler.lastName)
                TextField("Passport:", text: $bookingHandler.passport)
                    .padding([.bottom], 5)
            }
            .textFieldStyle(.roundedBorder)
            .font(Font.system(size: 25, design: .default))
            
            Group {
                HStack {
                    Text("Birthdate:")
                        .font(Font.system(size: 20))
                    
                    DatePicker("", selection: $bookingHandler.birthDate,displayedComponents: [.date])
                        .labelsHidden()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                }
            }
            
            
            Group {
                HStack {
                    Text("Gender:")
                        .font(Font.system(size: 20))
                    
                    Picker("Gender", selection: $bookingHandler.gender) {
                        Text("Male").tag(Gender.Male)
                        Text("Female").tag(Gender.Female)
                    }
                    .pickerStyle(.menu)
                    
                    Spacer()
                }
            }
            
            
            Group {
                HStack {
                    Text("Country:")
                        .font(Font.system(size: 20))
                    
                    Picker("Country", selection: $bookingHandler.country) {
                        ForEach(countries.sorted(by: { $0.name > $1.name })) {
                            Text($0.name)
                                .tag(Optional($0))
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Spacer()
                }
            }
            
            Button (action: {
                bookingHandler.finishBooking(flightID: flightID1)
                if flightID2 != nil {
                    bookingHandler.finishBooking(flightID: flightID2!)
                }
                self.rootIsActive = false
            } ){
                Text("Confirm")
            }
                .padding()
                .background(Color.purple)
                .foregroundColor(Color.white)
                .clipShape(Capsule())
            
           
            Spacer()
        }.padding(EdgeInsets(top: 30, leading: 30, bottom: 0, trailing: 30))
    }
}

//struct BookingView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookingView(flightID1: "BUD1")
//    }
//}
