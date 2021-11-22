//
//  GameRepository.swift
//  Gameformation
//
//  Created by Luis Genesius on 18/11/21.
//

import Foundation
import Combine

protocol GameRemoteRepositoryProtocol {
    
    func getGames() -> AnyPublisher<(String?, [GameModel]), Error>
    func getGame(id: Int) -> AnyPublisher<DetailGameModel, Error>
    func searchGame(query: String) -> AnyPublisher<(String?, [GameModel]), Error>
    func nextGames(url: URL) -> AnyPublisher<(String?, [GameModel]), Error>
}

final class GameRemoteRepository {
    
    private let remote: GameRemoteDataSource
    
    private init(remote: GameRemoteDataSource) {
        self.remote = remote
    }
    
    static let shared: (GameRemoteDataSource) -> GameRemoteRepository = { remote in
        return GameRemoteRepository(remote: remote)
    }
}

extension GameRemoteRepository: GameRemoteRepositoryProtocol {
    
    func getGames() -> AnyPublisher<(String?, [GameModel]), Error> {
        return remote.getGames()
            .map { ($0.next, GameMapper.mapGameResponseToGameModels(input: $0)) }
            .eraseToAnyPublisher()
    }
    
    func getGame(id: Int) -> AnyPublisher<DetailGameModel, Error> {
        return remote.getGame(id: id)
            .map { Converter.fromGameToDetailGameModel($0) }
            .eraseToAnyPublisher()
    }
    
    func searchGame(query: String) -> AnyPublisher<(String?, [GameModel]), Error> {
        return remote.searchGame(query: query)
            .map { ($0.next, GameMapper.mapGameResponseToGameModels(input: $0)) }
            .eraseToAnyPublisher()
    }
    
    func nextGames(url: URL) -> AnyPublisher<(String?, [GameModel]), Error> {
        return remote.nextGames(url: url)
            .map { ($0.next, GameMapper.mapGameResponseToGameModels(input: $0)) }
            .eraseToAnyPublisher()
    }
    
}
