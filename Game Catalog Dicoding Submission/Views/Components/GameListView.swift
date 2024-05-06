//
//  GameListView.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 04/05/24.
//

import SwiftUI

struct GameListView: View {
    var leftTitle: String
    var gamePopulars: [GameListResult]
    var nextUrl: String
    var body: some View {
        HStack {
            Text(leftTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.title3)
            Spacer()
            NavigationLink(destination: ListAllGameScreen(title: leftTitle, nextUrl: nextUrl)) {
                Text("See more")
                    .foregroundColor(Color("brandColor"))
            }
        }
        .padding(.leading, 10)
        .padding(.trailing, 10)
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(gamePopulars, id: \.id) { game in
                    NavigationLink(destination: DetailGameScreen(idGame: game.id)) {
                        GameCard(game: game)
                    }
                    .foregroundColor(.white)
                }
            }
        }
        .padding(.bottom, 10)
        .padding(.horizontal)
    }
}

#Preview {
    GameListView(leftTitle: "Popular Game", gamePopulars: MockData.gamesUpdated, nextUrl: "")
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
