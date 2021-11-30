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
    
    private let dateFormatter = DateFormatter()
    init() {
        dateFormatter.dateFormat = "YY/MM/dd hh:mm"
    }
    
    var body: some View {
        VStack {
            TabView {
                ForEach(boardingcards, id: \.self) { bc in
                    VStack {
                        
                        HStack {
                            VStack {
                                Text(bc.flight!.startingAirport!.code!)
                                Text(bc.flight!.startingAirport!.name!)
                            }
                            Spacer()
                            VStack {
                                Text(bc.flight!.destinationAirport!.code!)
                                Text(bc.flight!.destinationAirport!.name!)
                            }
                        }
                        
                        //Text(bc.id!)
                        
                        HStack {
                            Text(bc.firstName!)
                            Text(bc.lastName!)
                        }
                        
                        HStack {
                            Text(dateFormatter.string(from: bc.flight!.departureDate!))
                            Spacer()
                            Text(dateFormatter.string(from: bc.flight!.arriveDate!))
                        }
                    }
                }.tabViewStyle(.page).indexViewStyle(.page(backgroundDisplayMode: .always))
            }
        }
    }
}

//struct BoardingCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoardingCardView()
//    }
//}
