//
//  ListGameCell.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 05/05/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListGameCell: View {
    let game: GameListResult?
    var body: some View {
        HStack(spacing: 10) {
            WebImage(url: URL(string: game?.backgroundImage ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 100)
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 5) {
                Text(game?.name ?? "")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .fontWeight(.medium)
                ImageAndTextComponent(rating: game?.rating, iconName: "star.fill")
                    .font(.subheadline)
                ImageAndTextComponent(iconName: "calendar", textRight: formatDateString(game?.released))
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    ListGameCell(game: MockData.sampleGame2)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
