//
//  CarouselCard.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 03/05/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CarouselCard: View {
    @State private var currentIndex = 0
    var gameUpdate: [GameListResult]
    var body: some View {
        TabView {
            ForEach(gameUpdate, id: \.id) { game in
                NavigationLink(destination: DetailGameScreen(idGame: game.id)) {
                    WebImage(url: URL(string: game.backgroundImage))
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 40, height: 200)
                        .cornerRadius(10)
                        .overlay(
                            CardTextView(game.name, convertDate(dateString: game.released), game.rating)
                                .padding(.top, 20)
                                .padding(.bottom, 10)
                                .background(Color("bgCardColor"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .offset(x: 0, y: 0),
                            alignment: .bottom
                        )
                }
                .foregroundColor(.white)
            }
       }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
       .frame(height: 310)
   }
    @ViewBuilder
    func CardTextView(_ gameTitle: String, _ gameYear: String, _ gameRating: Double?) -> some View {
        HStack(alignment: .firstTextBaseline) {
          Text("\(gameTitle) \(gameYear)")
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .fontWeight(.bold)
           Spacer()
            ImageAndTextComponent(rating: gameRating!, iconName: "star.fill")
        }
        .padding(.top, -10)
        .padding(.leading)
        .padding(.trailing)
    }
    func convertDate(dateString: String?) -> String {
        if let dateString = dateString {
            let year = String(dateString.prefix(4))
            return year
        } else {
            return ""
        }
    }
}

#Preview {
    CarouselCard(gameUpdate: MockData.gamesUpdated)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
