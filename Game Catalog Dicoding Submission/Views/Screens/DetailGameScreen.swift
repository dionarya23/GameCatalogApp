//
//  DetailGameScreen.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 04/05/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailGameScreen: View {
    @StateObject var detailGameViewModel = DetailGameViewModel()
    @StateObject var wishListViewModel = WishlistViewModel()
    @State var isLoading: Bool = false
    var idGame: Int
    var body: some View {
        ScrollView {
            VStack {
                WebImage(url: URL(string: detailGameViewModel.gameDetail?.backgroundImage ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 350)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
                Text(detailGameViewModel.gameDetail?.name ?? "")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity)
                    .padding()
                VStack(alignment: .leading, spacing: 10) {
                    ImageAndTextComponent(rating: detailGameViewModel.gameDetail?.rating, iconName: "star.fill")
                    ImageAndTextComponent(iconName: "calendar",
                                          textRight:
                                            formatDateString(detailGameViewModel.gameDetail?.released))
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(detailGameViewModel.gameDetail?.genres ?? [], id: \.id) { genre in
                                TagComponent(title: genre.name)
                            }
                        }
                        .padding(.top, 10)
                    }
                }
                gameDescription
                    .padding(.top)
            }
        }
        .overlay(
            Group {
                if isLoading {
                    ProgressView()
                }
            }
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                loveButton
            }
        }
        .navigationTitle(detailGameViewModel.gameDetail?.name ?? "")
        .padding()
        .onAppear {
            isLoading = true
            wishListViewModel.fetchChekedIsLoved(gameId: idGame)
            detailGameViewModel.fetchDetailGame(idGame: idGame) {
                isLoading = false
            }
        }
        .alert(item: $detailGameViewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
    private var loveButton: some View {
        Button(action: {
           let isLove = !wishListViewModel.isLoved
            if  isLove {
                let genreIds = detailGameViewModel.gameDetail?.genres.map { String($0.id) }.joined(separator: ",")
                wishListViewModel.addWishlist(
                    id: detailGameViewModel.gameDetail?.id ?? 0,
                    name: detailGameViewModel.gameDetail?.name ?? "",
                    rating: detailGameViewModel.gameDetail?.rating ?? 0.0,
                    backgroundImage: detailGameViewModel.gameDetail?.backgroundImage ?? "",
                    released: detailGameViewModel.gameDetail?.released ?? "",
                    genreIds: genreIds!)
                wishListViewModel.fetchChekedIsLoved(gameId: idGame)
                detailGameViewModel.showLoveAlert(description: "Berhasil menambahkan game ke favorite")
            } else {
                wishListViewModel.deleteWishlist(gameId: detailGameViewModel.gameDetail?.id ?? 0)
                wishListViewModel.fetchChekedIsLoved(gameId: idGame)
                detailGameViewModel.showLoveAlert(description: "Berhasil menghapus game dari favorite")
            }
        }, label: {
            Image(systemName: wishListViewModel.isLoved ? "heart.fill" : "heart")
                .foregroundColor(Color("brandColor"))
                .frame(width: 40, height: 40)
                .padding()
        })
    }

    private var gameDescription: some View {
        VStack(alignment: .leading) {
            Text("Game Description")
                .font(.title2)
                .padding(.bottom, 8)
            Text(detailGameViewModel.gameDetail?.descriptionRaw ?? "")
                .font(.subheadline)
                .fontWeight(.light)
                .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    DetailGameScreen(
        idGame: 3498
    )
    .preferredColorScheme(.dark)
}
