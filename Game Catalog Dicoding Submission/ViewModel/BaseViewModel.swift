//
//  BaseViewModel.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 04/05/24.
//

import Foundation
import SwiftUI

class BaseViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    private let networkManager = NetworkManager.shared

    func handleError(_ error: ApError) {
        switch error {
        case .invalidResponse:
            alertItem = AlertContext.invalidResponse
        case .invalidData:
            alertItem = AlertContext.invalidData
        case .invalidURL:
            alertItem = AlertContext.invalidURL
        case .unableToComplete:
            alertItem = AlertContext.unableToComplete
        case .dataNotFound:
            alertItem = AlertContext.dataNotFound
        }
    }

    func showLoveAlert(description: String) {
        alertItem = AlertItem(title: Text("Berhasil!"),
                              message: Text(description),
                              dismissButton: .default(Text("Ok")))
    }
}
