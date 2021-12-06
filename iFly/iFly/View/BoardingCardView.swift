//
//  BoardingCardView.swift
//  iFly
//
//  Created by Henrik Berényi on 2021. 11. 30..
//

import SwiftUI

struct BoardingCardView: View {
    @FetchRequest(
        entity: BoardingCard.entity(),
        sortDescriptors: []
    ) var boardingcards: FetchedResults<BoardingCard>

    var body: some View {
        VStack {
            TabView {
                ForEach(boardingcards, id: \.self) { bc in
                    ScrollView {
                        VStack {
                            BarcodeView()
                            
                            DottedLine()
                                .stroke(style: StrokeStyle(lineWidth: 3, dash: [5]))
                                .frame(height: 1)
                                .foregroundColor(Color.gray)
                            
                            FlightView(bc: bc)
                            
                            DottedLine()
                                .stroke(style: StrokeStyle(lineWidth: 3, dash: [5]))
                                .frame(height: 1)
                                .foregroundColor(Color.gray)
                            
                            NameView(bc: bc)
                            
                            DateView(bc: bc)

                            DottedLine()
                                .stroke(style: StrokeStyle(lineWidth: 3, dash: [5]))
                                .frame(height: 1)
                                .foregroundColor(Color.gray)
                            
                            IDView(bc: bc)
                            
                            DataView(bc: bc)

                            Spacer()
                        }
                        
                    }
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}


struct BarcodeView: View {
    var body: some View {
        Image("Barcode")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(EdgeInsets(top: 20, leading: 50, bottom: 15, trailing: 50))
    }
}

struct FlightView: View {
    private var bc:BoardingCard
    init(bc: BoardingCard) {
        self.bc = bc
    }
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(bc.flight!.startingAirport!.code!)
                    .font(.largeTitle)
                Text(bc.flight!.startingAirport!.name!)
            }
            .foregroundColor(Color(red: 0.0, green: 0.0, blue: 1.0))
            
            Spacer()
            
            VStack {
                Text(bc.flight!.id!)
                Image(systemName: "airplane")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(bc.flight!.destinationAirport!.code!)
                    .font(.largeTitle)
                Text(bc.flight!.destinationAirport!.name!)
            }
            .foregroundColor(Color(red: 0.0, green: 0.0, blue: 1.0))

        }
        .padding(EdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25))
    }
}

struct NameView: View {
    private var bc:BoardingCard
    init(bc: BoardingCard) {
        self.bc = bc
    }
    var body: some View {
        HStack {
            Text(bc.firstName!)
            Text(bc.lastName!)
            Spacer()
        }
        .padding(EdgeInsets(top: 15, leading: 25, bottom: 0, trailing: 0))
            .font(.system(size: 20))
        
        HStack {
            Text("Name")
                .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))
                .font(.system(size: 16))
                .foregroundColor(Color.gray)
            Spacer()
        }
    }
}

struct DateView: View {
    private var bc:BoardingCard
    private let dayMonth = DateFormatter()
    private let hourMinute = DateFormatter()
    init(bc: BoardingCard) {
        self.bc = bc
        dayMonth.dateFormat = "dd MMM"
        hourMinute.dateFormat = "hh:mm"
    }
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Date")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                Text(dayMonth.string(from: bc.flight!.departureDate!))
                    .font(.system(size: 23))
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Departure")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                Text(hourMinute.string(from: bc.flight!.departureDate!))
                    .font(.system(size: 23))
            }
            
        }
        .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
            .background(Color(red: 0.0, green: 0.0, blue: 1.0))
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity)
            .frame(height: 100, alignment: .center)
    }
}

struct IDView: View {
    private var bc:BoardingCard
    init(bc: BoardingCard) {
        self.bc = bc
    }
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("PNR")
                    .foregroundColor(Color.gray)
                Text(bc.id!)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 40))
            Spacer()
        }
        .padding(EdgeInsets(top: 10, leading: 25, bottom: 15, trailing: 25))
    }
}

struct DataView: View {
    private var bc:BoardingCard
    private let birthDateFormatter = DateFormatter()
        
    init(bc: BoardingCard) {
        self.bc = bc
        birthDateFormatter.dateFormat = "dd-MM-YYYY"
    }
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Group {
                    Text("Passport")
                    Text("Issued by")
                    Text("Gender")
                    Text("Birthdate")
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                .foregroundColor(Color.gray)
                        }
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 35))
            
            VStack(alignment: .leading) {
                Group {
                    Text(bc.passport!)
                    Text(bc.country!)
                    Text(bc.gender!)
                    Text(birthDateFormatter.string(from: bc.birthdate!))
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
            }

            Spacer()
        }
        .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
    }
}

//struct BoardingCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoardingCardView()
//    }
//}
