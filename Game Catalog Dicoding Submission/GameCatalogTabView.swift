//
//  ContentView.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 03/05/24.
//

import SwiftUI

struct GameCatalogTabView: View {
    @State private var activeTab: Tabs = .home
    var body: some View {
        TabView(selection: $activeTab) {
            Home()
                .tag(Tabs.home)
                .tabItem { Tabs.home.tabContent }
            Wishlist()
                .tag(Tabs.wishlist)
                .tabItem { Tabs.wishlist.tabContent }
            Search()
                .tag(Tabs.search)
                .tabItem { Tabs.search.tabContent }
        }
        .accentColor(Color("brandColor"))
    }
}

#Preview {
    GameCatalogTabView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
