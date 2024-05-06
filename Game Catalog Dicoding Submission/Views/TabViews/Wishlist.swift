//
//  Wishlist.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 03/05/24.
//

import SwiftUI

struct Wishlist: View {
    @StateObject var wishListViewModel = WishlistViewModel()

    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    var listGenre = MockGenreData().listGenre
    var msgDelete = "Berhasil menghapus game dari favorite"

    var body: some View {
        NavigationView {
            VStack {
            if wishListViewModel.savedEntity.isEmpty {
                    Image("gameIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    Text("Favorite Masih Kosong")
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(listGenre.results, id: \.id) { genre in
                                TagComponent(title: genre.name,
                                             isSelected: wishListViewModel.selectedGenreId == genre.id)
                                .onTapGesture {
                                    if wishListViewModel.selectedGenreId != genre.id {
                                        wishListViewModel.selectedGenreId = genre.id
                                        wishListViewModel.fetchWishlist()
                                    } else {
                                        wishListViewModel.selectedGenreId = -1
                                        wishListViewModel.fetchWishlist()
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(wishListViewModel.filteredEntity, id: \.id) { game in
                                NavigationLink {
                                    DetailGameScreen(idGame: Int(game.id))
                                } label: {
                                    GameCard(
                                        game: GameListResult(
                                            id: Int(game.id),
                                            name: game.name ?? "",
                                            released: game.released,
                                            backgroundImage: game.backgroundImage ?? "",
                                            rating: game.rating
                                        )
                                    )
                                    .overlay(
                                        Button(action: {
                                            wishListViewModel.deleteWishlist(gameId: Int(game.id))
                                            wishListViewModel.showLoveAlert(description: msgDelete)
                                        }, label: {
                                            Image(systemName: "heart.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(Color("brandColor"))
                                        })
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 10)
                                        .background(Color("bgCardColor"))
                                        .clipShape(RoundedRectangle(cornerRadius: 24))
                                        .offset(x: -10, y: 10),
                                        alignment: .topTrailing
                                    )
                                }
                                .foregroundColor(.white)
                            }
                        }
                        .padding(.top, 10)
                        .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Favorite")
            .onAppear {
                wishListViewModel.fetchWishlist()
            }
        }
    }
}

#Preview {
    Wishlist()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
