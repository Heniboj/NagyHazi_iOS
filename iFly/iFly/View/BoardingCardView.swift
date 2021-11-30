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
                    HStack {
                        Text(bc.firstName!)
                        Text(bc.lastName!)
                    }
                }
            }.tabViewStyle(.page).indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

//struct BoardingCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoardingCardView()
//    }
//}
