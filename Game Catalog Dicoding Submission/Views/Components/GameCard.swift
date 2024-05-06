//
//  GameCard.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 04/05/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameCard: View {
    var game: GameListResult
    var body: some View {
            WebImage(url: URL(string: game.backgroundImage))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 170, height: 300)
            .cornerRadius(10)
            .overlay(cardText
                .padding(.top, -10)
                .padding(.horizontal, 10)
                .padding(.vertical, 20)
                .background(Color("bgCardColor"))
                .offset(x: 0, y: 0),
                alignment: .bottom)
        }

    var cardText: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(game.name)
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    .bold()
                ImageAndTextComponent(rating: game.rating!, iconName: "star.fill")
                    .font(.subheadline)
                ImageAndTextComponent(iconName: "calendar", textRight: formatDateString(game.released))
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}

#Preview {
    GameCard(game: MockData.sampleGame)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
