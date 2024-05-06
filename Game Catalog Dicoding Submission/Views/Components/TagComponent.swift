//
//  TagComponent.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 04/05/24.
//

import SwiftUI

struct TagComponent: View {
    var title: String
    var isSelected: Bool = false
    var body: some View {
            Text(title)
                .font(.caption)
                .bold()
                .foregroundColor(isSelected ? .black : .gray)
                .padding(10)
                .background(isSelected ? Color.white : Color("bgCardColor"))
                .cornerRadius(10)
        }
}

#Preview {
    TagComponent(title: "Action")
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
