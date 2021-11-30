//
//  RemoteDataSource.swift
//  Gameformation
//
//  Created by Luis Genesius on 18/11/21.
//

import Foundation
import Alamofire
import Combine

/*
protocol GameRemoteDataSourceProtocol {
    
    func getGames() -> AnyPublisher<GameResponse, Error>
    func getGame(id: Int) -> AnyPublisher<Game, Error>
    func searchGame(query: String) -> AnyPublisher<GameResponse, Error>
    func nextGames(url: URL) -> AnyPublisher<GameResponse, Error>
}

final class GameRemoteDataSource {
    static let shared = GameRemoteDataSource()
    
    private init() {}
}

extension GameRemoteDataSource: GameRemoteDataSourceProtocol {
    
    func getGames() -> AnyPublisher<GameResponse, Error> {
        return Future<GameResponse, Error> { completion in
            if let url = URL(string: API.Endpoint.games.urlString) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GameResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getGame(id: Int) -> AnyPublisher<Game, Error> {
        return Future<Game, Error> { completion in
            if let url = URL(string: API.Endpoint.game(id: id).urlString) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: Game.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func searchGame(query: String) -> AnyPublisher<GameResponse, Error> {
        return Future<GameResponse, Error> { completion in
            if let url = URL(string: API.Endpoint.search(query: query).urlString) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GameResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func nextGames(url: URL) -> AnyPublisher<GameResponse, Error> {
        return Future<GameResponse, Error> { completion in
            AF.request(url)
                .validate()
                .responseDecodable(of: GameResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
*/
