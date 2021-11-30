//
//  File.swift
//  
//
//  Created by Luis Genesius on 28/11/21.
//

import Foundation
import Combine
import Alamofire
import Core

public struct GameRemoteDataSource: RemoteDataSource {
    public typealias Request = Any
    public typealias Response = Game
    
    public init() {}
    
    public func list(request: Any?) -> AnyPublisher<(String?, [Game]), Error> {
        return Future<(String?, [Game]), Error> { completion in
            if let url = URL(string: GameAPI.Endpoint.games.urlString) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GameResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success((value.next, value.games)))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<Game, Error> {
        return Future<Game, Error> { completion in
            if let url = URL(string: GameAPI.Endpoint.game(id: id).urlString) {
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
    
    public func search(query: String) -> AnyPublisher<(String?, [Game]), Error> {
        return Future<(String?, [Game]), Error> { completion in
            if let url = URL(string: GameAPI.Endpoint.search(query: query).urlString) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GameResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success((value.next, value.games)))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func next(url: URL) -> AnyPublisher<(String?, [Game]), Error> {
        return Future<(String?, [Game]), Error> { completion in
            AF.request(url)
                .validate()
                .responseDecodable(of: GameResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success((value.next, value.games)))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
