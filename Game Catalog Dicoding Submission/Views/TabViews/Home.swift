//
//  Home.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 03/05/24.
//

import SwiftUI

struct Home: View {
    @StateObject var gameViewModel = HomeViewModel()
    @State private var isLoading = false
    @State private var dummyNextUrl = "https://rawg-mirror.vercel.app/api/games"

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    CarouselCard(gameUpdate: gameViewModel.gameUpdatedList)
                    GameListView(leftTitle: "Popular Game", gamePopulars: gameViewModel.gamePopularList?.results ?? [],
                                 nextUrl: dummyNextUrl)
                    GameListView(leftTitle: "New Game", gamePopulars: gameViewModel.gameNewList?.results ?? [],
                    nextUrl: dummyNextUrl)
                }
                .padding(.top, -30)
                .overlay(
                    Group {
                        if isLoading {
                            ProgressView()
                        }
                    }
                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Welcome, Dion!")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileScreen()) {
                        Image(systemName: "person.crop.circle")
                            .foregroundColor(Color("brandColor"))
                            .frame(width: 40, height: 40)
                            .padding()
                    }
                }
            }
        }
        .onAppear {
            if gameViewModel.gameNewList?.results.isEmpty ?? true
                && gameViewModel.gamePopularList?.results.isEmpty ?? true
                && gameViewModel.gameUpdatedList.isEmpty {
                isLoading = true
                gameViewModel.fetchAllGameHomeScreen { isLoading = false }
            }
                    }
        .alert(item: $gameViewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    Home()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
