//
//  SplashScreen.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 03/05/24.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        Image("logoApp")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 350, height: 350)
    }
}

#Preview {
    SplashScreen()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
