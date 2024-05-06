//
//  Tab.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 03/05/24.
//

import SwiftUI

enum Tabs: String {
    case home = "Home"
    case wishlist = "Favorite"
    case search = "Search"
    @ViewBuilder
    var tabContent: some View {
        switch self {
        case .home:
            Image(systemName: "house")
            Text(self.rawValue)
        case .wishlist:
            Image(systemName: "heart")
            Text(self.rawValue)
        case .search:
            Image(systemName: "magnifyingglass")
            Text(self.rawValue)
        }
    }
}
