//
//  Genre.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 05/05/24.
//

import Foundation

struct GenreModel: Decodable {
    let results: [GenreResult]
}

struct GenreResult: Decodable, Identifiable {
    let id: Int
    let name: String
}

struct MockGenreData {

    static let sampleGenre = GenreResult(id: 4, name: "Action")
    static let sampleGenre2 = GenreResult(id: 51, name: "Indie")
    static let sampleGenre3 = GenreResult(id: 3, name: "Adventure")
    static let sampleGenre4 = GenreResult(id: 7, name: "Puzzle")
    static let sampleGenre5 = GenreResult(id: 2, name: "Shooter")
    static let sampleGenre6 = GenreResult(id: 5, name: "RPG")

    let listGenre = GenreModel(results: [
        sampleGenre,
        sampleGenre2,
        sampleGenre3,
        sampleGenre4,
        sampleGenre5,
        sampleGenre6
    ])
}
