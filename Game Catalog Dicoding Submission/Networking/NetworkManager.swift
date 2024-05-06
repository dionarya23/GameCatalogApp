//
//  NetworkManager.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 04/05/24.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    static let baseURL = URL(string: "https://rawg-mirror.vercel.app/api/games")

    private var apiKey: String {
            guard let filePath = Bundle.main.path(
                forResource: "RAWG-Info",
                ofType: "plist") else {
              fatalError("Couldn't find file 'RAWG-Info.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
              fatalError("Couldn't find key 'API_KEY' in 'RAWG-Info.plist'.")
            }
            return value
    }

    private func fetchData<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, ApError>) -> Void
    ) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.unableToComplete))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 404:
                        completion(.failure(.dataNotFound))
                    default:
                        completion(.failure(.invalidResponse))
                    }
                } else {
                    completion(.failure(.invalidResponse))
                }
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }

    func getUpdatedGame(completed: @escaping (Result<[GameListResult], ApError>) -> Void) {
        guard let baseURL = Self.baseURL else {
            completed(.failure(.invalidURL))
            return
        }
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "page_size", value: "5"),
            URLQueryItem(name: "ordering", value: "-updated")
        ]
        guard let url = components?.url else {
            completed(.failure(.invalidURL))
            return
        }
        fetchData(url: url, completion: { (result: Result<GameListModel, ApError>) in
            switch result {
            case .success(let gameList):
                completed(.success(gameList.results))
            case .failure(let error):
                completed(.failure(error))
            }
        })
    }

    func getPopularGame(completed: @escaping (Result<GameListModel, ApError>) -> Void) {
        guard let baseURL = Self.baseURL else {
            completed(.failure(.invalidURL))
            return
        }
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "page_size", value: "5"),
            URLQueryItem(name: "ordering", value: "-rating")
        ]
        guard let url = components?.url else {
            completed(.failure(.invalidURL))
            return
        }
        fetchData(url: url, completion: completed)
    }

    func getNewGame(completed: @escaping (Result<GameListModel, ApError>) -> Void) {
        guard let baseURL = Self.baseURL else {
            completed(.failure(.invalidURL))
            return
        }
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "page_size", value: "5"),
            URLQueryItem(name: "ordering", value: "-created")
        ]
        guard let url = components?.url else {
            completed(.failure(.invalidURL))
            return
        }
        fetchData(url: url, completion: completed)
    }

    func getDetailGame(idGame: Int, completed: @escaping (Result<GameDetailResult, ApError>) -> Void) {
        guard let baseURL = Self.baseURL else {
            completed(.failure(.invalidURL))
            return
        }
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.path = "/api/games/\(idGame)"
        components?.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        guard let url = components?.url else {
            completed(.failure(.invalidURL))
            return
        }
        fetchData(url: url, completion: completed)
    }

    func getNextPageGame(nextUrl: String, completed: @escaping (Result<GameListModel, ApError>) -> Void) {
        guard let url = URL(string: nextUrl) else {
            completed(.failure(.invalidURL))
            return
        }
        fetchData(url: url, completion: completed)
    }

    func getSearchGame(keyword: String, completed: @escaping (Result<[GameListResult], ApError>) -> Void) {
        guard let baseURL = Self.baseURL else {
            completed(.failure(.invalidURL))
            return
        }
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "page_size", value: "15"),
            URLQueryItem(name: "search", value: keyword)
        ]
        guard let url = components?.url else {
            completed(.failure(.invalidURL))
            return
        }
        fetchData(url: url, completion: { (result: Result<GameListModel, ApError>) in
            switch result {
            case .success(let gameList):
                completed(.success(gameList.results))
            case .failure(let error):
                completed(.failure(error))
            }
        })
    }
}
