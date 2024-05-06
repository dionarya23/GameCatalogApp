//
//  GameViewModel.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 04/05/24.
//

import Foundation

final class HomeViewModel: BaseViewModel {
    @Published var gameUpdatedList: [GameListResult] = []
    @Published var gamePopularList: GameListModel?
    @Published var gameNewList: GameListModel?

    private let networkManager = NetworkManager.shared

    func fetchAllGameHomeScreen(completion: @escaping () -> Void) {
        fetchUpdatedGames {
            self.fetchPopularGames {
                self.fetchNewGames {
                    completion()
                }
            }
        }
    }

    private func fetchUpdatedGames(completion: @escaping () -> Void) {
        self.networkManager.getUpdatedGame { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let updatedGame):
                    self?.gameUpdatedList = updatedGame
                case .failure(let error):
                    self?.handleError(error)
                }
                completion()
            }
        }
    }

    private func fetchPopularGames(completion: @escaping () -> Void) {
        networkManager.getPopularGame { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let popularGame):
                    self?.gamePopularList = popularGame
                case .failure(let error):
                    self?.handleError(error)
                }
                completion()
            }
        }
    }

    private func fetchNewGames(completion: @escaping () -> Void) {
        networkManager.getNewGame { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newGame):
                    self?.gameNewList = newGame
                case .failure(let error):
                    self?.handleError(error)
                }
                completion()
            }
        }
    }

}
