//
//  DetailGameViewModel.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 04/05/24.
//

import Foundation
import SwiftUI

final class DetailGameViewModel: BaseViewModel {
    @Published var gameDetail: GameDetailResult?
    private let networkManager = NetworkManager.shared

    func fetchDetailGame(idGame: Int, completion: @escaping () -> Void) {
        networkManager.getDetailGame(idGame: idGame) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let gameDetail):
                    self?.gameDetail = gameDetail
                case .failure(let error):
                    self?.handleError(error)
                }
                completion()
            }
        }
    }
}
