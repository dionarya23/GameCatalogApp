//
//  Search.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 03/05/24.
//

import SwiftUI

struct Search: View {
    @State var isLoading: Bool = false
    @StateObject var searchViewModel = SearchViewModel()
    var listgame = MockData.gamesUpdated

    var body: some View {
        NavigationStack {
            List {
                ForEach(searchViewModel.gameListResult, id: \.id) { game in
                    NavigationLink(destination: DetailGameScreen(idGame: game.id)) {
                        ListGameCell(game: game)
                    }
                }
            }
            .overlay(
                Group {
                    if isLoading {
                        ProgressView()
                    }
                }
            )
            .listStyle(.plain)
            .navigationTitle("Search Game")
            .searchable(text: $searchViewModel.searchText)
            .onChange(of: searchViewModel.searchText) { searchText in
            if !searchText.isEmpty && searchText.count >= 3 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isLoading = true
                    searchViewModel.fetchSearch(keyword: searchText) {
                        isLoading = false
                    }
                  }
            } else {
                searchViewModel.gameListResult = []
                }
            }
        }
        .alert(item: $searchViewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    Search()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
