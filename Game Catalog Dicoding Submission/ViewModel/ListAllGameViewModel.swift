//
//  ListAllGameViewModel.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 04/05/24.
//

import Foundation

final class ListAllGameViewModel: BaseViewModel {
    @Published var gameListModel: GameListModel?
    @Published var gameListResult: [GameListResult] = []
    private let networkManager = NetworkManager.shared

    func fetchNextPage(nextUrl: String, completion: @escaping () -> Void) {
        networkManager.getNextPageGame(nextUrl: nextUrl) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let gameList):
                    self?.gameListModel = gameList
                    self!.gameListResult += gameList.results
                case .failure(let error):
                    self?.handleError(error)
                }
                completion()
            }
        }
    }
}
