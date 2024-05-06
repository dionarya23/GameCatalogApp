//
//  SearchViewModel.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 05/05/24.
//

import Foundation

final class SearchViewModel: BaseViewModel {

    @Published var gameListResult: [GameListResult] = []
    @Published var searchText: String = ""
    private let networkManager = NetworkManager.shared

    func fetchSearch(keyword: String, completion: @escaping () -> Void) {
        networkManager.getSearchGame(keyword: keyword) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let gameList):
                    self.gameListResult = gameList
                case .failure(let error):
                    self.handleError(error)
                }
                completion()
            }
        }
    }

}
