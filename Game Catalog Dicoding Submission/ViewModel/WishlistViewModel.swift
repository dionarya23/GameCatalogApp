//
//  WishlistViewModel.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 05/05/24.
//

import Foundation
import CoreData

final class WishlistViewModel: BaseViewModel {
    @Published var selectedGenreId: Int = -1
    @Published var savedEntity: [WishlistEntity] = []
    @Published var filteredEntity: [WishlistEntity] = []
    @Published var isLoved: Bool = false

    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameContainer")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error Loading core data. \(error)")
            }
        }
        return container
    }()

    func fetchChekedIsLoved(gameId: Int) {
        fetchWishlist()
        isLoved = !savedEntity.filter { $0.id == gameId }.isEmpty
    }

    func fetchWishlist() {
        let request = NSFetchRequest<WishlistEntity>(entityName: "WishlistEntity")
        do {
            let fetchedResult = try container.viewContext.fetch(request)
            if selectedGenreId != -1 {
                filteredEntity = fetchedResult.filter { $0.genreIds?.contains("\(selectedGenreId)") ?? false }
            } else {
                filteredEntity = fetchedResult
            }
            savedEntity = fetchedResult
        } catch {
            print("Error fetching. \(error)")
        }
    }

    func addWishlist(id: Int, name: String, rating: Double,
                     backgroundImage: String, released: String,
                     genreIds: String) {
        let newWishlist = WishlistEntity(context: container.viewContext)
        newWishlist.id = Int32(id)
        newWishlist.name = name
        newWishlist.rating = rating
        newWishlist.backgroundImage = backgroundImage
        newWishlist.released = released
        newWishlist.genreIds = genreIds
        savedData()
    }

    func savedData() {
        do {
            try container.viewContext.save()
            fetchWishlist()
        } catch {
            print("Error saving. \(error)")
        }
    }

    func deleteWishlist(gameId: Int) {
        let gameWillDelete: WishlistEntity? = savedEntity.filter({ $0.id == gameId }).first
        if let gameWillDelete = gameWillDelete {
            container.viewContext.delete(gameWillDelete)
            savedData()
       }
    }
}
