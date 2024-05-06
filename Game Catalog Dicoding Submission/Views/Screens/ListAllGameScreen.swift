//
//  ListAllGameScreen.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 04/05/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListAllGameScreen: View {
    @StateObject var listAllGameViewModel = ListAllGameViewModel()
    @State var isLoading: Bool = false

    var title: String?
    var nextUrl: String
    var dummyNextUrl = "https://rawg-mirror.vercel.app/api/games"

    var body: some View {
        List {
            ForEach(listAllGameViewModel.gameListResult, id: \.id) { game in
                NavigationLink(destination: DetailGameScreen(idGame: game.id)) {
                    ListGameCell(game: game)
                }
                .onAppear {
                    let lastIndex = listAllGameViewModel.gameListResult.count - 1
                    if game.id == listAllGameViewModel.gameListResult[lastIndex].id {
                        listAllGameViewModel.fetchNextPage(
                            nextUrl: dummyNextUrl
                        ) {
                            isLoading = false
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .overlay(
            Group {
                if isLoading {
                    ProgressView()
                }
            }
        )
        .navigationTitle(title!)
        .onAppear {
            isLoading = true
            listAllGameViewModel.fetchNextPage(nextUrl: nextUrl) {
                isLoading = false
            }
        }
        .alert(item: $listAllGameViewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    ListAllGameScreen(
        title: "Popular Games",
        nextUrl: """
https://api.rawg.io/api/games?key=9ad0aca67b0a429baf6a0d6cca182f47&ordering=-rating&page=2&page_size=5
""")
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
